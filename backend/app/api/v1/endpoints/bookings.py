from typing import Any, List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.core.database import get_db
from app.schemas.booking import BookingRequest, BookingResponse
from app.services.booking_service import create_booking_transaction, cancel_booking_transaction
from app.api.deps import get_current_user 
from app.models.user import User
from app.models.booking import Booking

router = APIRouter()

@router.post("/", response_model=BookingResponse)
def create_booking(
    *,
    db: Session = Depends(get_db),
    booking_in: BookingRequest,
    current_user: User = Depends(get_current_user)
) -> Any:
    """
    Create a new booking.
    """
    booking_in.user_id = current_user.user_id 
    
    booking = create_booking_transaction(db, booking_in)
    return booking

@router.get("/", response_model=List[BookingResponse])
def get_my_bookings(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
) -> Any:
    """
    Get all bookings for the current user.
    Includes nested flight and ticket details.
    """
    return db.query(Booking).filter(Booking.user_id == current_user.user_id).all()

@router.get("/{booking_id}", response_model=BookingResponse)
def get_booking_details(
    booking_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
) -> Any:
    """
    Get details for a specific booking.
    """
    booking = db.query(Booking).filter(Booking.booking_id == booking_id).first()
    
    if not booking:
        raise HTTPException(status_code=404, detail="Booking not found")

    if booking.user_id != current_user.user_id:
        raise HTTPException(status_code=403, detail="Not authorized to view this booking")
        
    return booking

@router.delete("/{booking_id}")
def cancel_booking(
    booking_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
) -> Any:
    """
    Cancel a booking (Customer self-service).
    """
    booking = db.query(Booking).filter(Booking.booking_id == booking_id).first()
    
    if not booking:
        raise HTTPException(status_code=404, detail="Booking not found")
        
    if booking.user_id != current_user.user_id:
        raise HTTPException(status_code=403, detail="Not authorized to cancel this booking")
        
    return cancel_booking_transaction(db, booking_id)