from sqlalchemy.orm import Session
from fastapi import HTTPException
from app.models.booking import Booking, Payment, Ticket
from app.models.fleet import Flight, Seat
from app.schemas.booking import BookingRequest

def create_booking_transaction(db: Session, booking_req: BookingRequest):
    flight = db.query(Flight).filter(Flight.flight_id == booking_req.flight_id).first()
    if not flight:
        raise HTTPException(status_code=404, detail="Flight not found")

    requested_seat_ids = [s.seat_id for s in booking_req.selected_seats]
    
    existing_tickets = db.query(Ticket).filter(
        Ticket.flight_id == booking_req.flight_id,
        Ticket.seat_id.in_(requested_seat_ids)
    ).count()
    
    if existing_tickets > 0:
        raise HTTPException(status_code=400, detail="One or more selected seats are already taken")

    # 3. Calculate Total Cost
    # (Seat Count * BaseFare)
    base_fare = flight.route.base_fare
    total_cost = base_fare * len(requested_seat_ids)

    try:
        # 4. Create Booking Record
        new_booking = Booking(
            user_id=booking_req.user_id,
            total_cost=total_cost,
            booking_status="Confirmed" 
        )
        db.add(new_booking)
        db.flush()

        # 5. Create Payment Record (Simulating success)
        new_payment = Payment(
            booking_id=new_booking.booking_id,
            amount=total_cost,
            payment_method=booking_req.payment_method,
            payment_status="Completed",
            transaction_id="TXN_SIMULATED_123"
        )
        db.add(new_payment)

        # 6. Create Tickets
        for seat_req in booking_req.selected_seats:
            ticket = Ticket(
                booking_id=new_booking.booking_id,
                flight_id=booking_req.flight_id,
                seat_id=seat_req.seat_id,
                traveler_first_name=seat_req.traveler_first_name,
                traveler_last_name=seat_req.traveler_last_name,
                ticket_price=base_fare
            )
            db.add(ticket)

        db.commit()
        db.refresh(new_booking)
        return new_booking

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"Booking failed: {str(e)}")
    

def cancel_booking_transaction(db: Session, booking_id: int):
    booking = db.query(Booking).filter(Booking.booking_id == booking_id).first()
    if not booking:
        raise HTTPException(status_code=404, detail="Booking not found")
        
    if booking.booking_status == "Cancelled":
         raise HTTPException(status_code=400, detail="Booking is already cancelled")

    try:
        booking.booking_status = "Cancelled"
        
        db.query(Ticket).filter(Ticket.booking_id == booking_id).delete()

        db.commit()
        db.refresh(booking)
        return {"message": "Booking cancelled successfully"}
        
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"Cancellation failed: {str(e)}")