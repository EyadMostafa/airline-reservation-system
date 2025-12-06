from typing import List, Optional
from datetime import date
from sqlalchemy.orm import Session
from sqlalchemy import func
from app.crud.base import CRUDBase
from app.models.fleet import Flight, FlightRoute, Seat
from app.models.booking import Ticket
from app.schemas.flight import FlightCreate, FlightStatusUpdate

class CRUDFlight(CRUDBase[Flight, FlightCreate, FlightStatusUpdate]):
    
    def search_flights(
        self, 
        db: Session, 
        origin: str, 
        destination: str, 
        departure_date: date
    ) -> List[Flight]:
        
        return (
            db.query(Flight)
            .join(FlightRoute)
            .filter(FlightRoute.origin == origin)
            .filter(FlightRoute.destination == destination)
            .filter(func.date(Flight.departure_time) == departure_date)
            .all()
        )

    def get_seat_availability(self, db: Session, flight_id: int):
        flight = db.query(Flight).filter(Flight.flight_id == flight_id).first()
        if not flight:
            return None
            
        aircraft_type_id = flight.aircraft.aircraft_type_id
        
        all_seats = db.query(Seat).filter(Seat.aircraft_type_id == aircraft_type_id).all()
        
        booked_tickets = db.query(Ticket).filter(Ticket.flight_id == flight_id).all()
        booked_seat_ids = {ticket.seat_id for ticket in booked_tickets}
        
        results = []
        for seat in all_seats:
            is_taken = seat.seat_id in booked_seat_ids
            results.append({
                "seat_id": seat.seat_id,
                "seat_number": seat.seat_number,
                "seat_class": seat.seat_class,
                "is_available": not is_taken
            })
            
        return results

flight = CRUDFlight(Flight)