from typing import Any, List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.core.database import get_db
from app.schemas.booking import BookingRequest, BookingResponse, BookingSummary
from app.services.booking_service import create_booking_transaction
from app.api.deps import get_current_user
from app.models.user import User
from app.models.booking import Booking
from app.crud.booking import booking

router = APIRouter()

@router.post("/", response_model=BookingResponse)
def create_booking(
    *,
    db: Session = Depends(get_db),
    booking_in: BookingRequest,
    current_user: User = Depends(get_current_user)
) -> Any:
    """
    Create a new booking with payments and tickets.
    """
    booking_in.user_id = current_user.user_id
    
    booking = create_booking_transaction(db, booking_in)
    return booking

@router.get("/", response_model=List[BookingSummary])
def get_my_bookings(
    db: Session = Depends(get_db),
    skip: int = 0,
    limit: int = 100,
    current_user: User = Depends(get_current_user)
) -> Any:
    """
    Retrieve bookings for the current logged-in user.
    """
    bookings = booking.get_multi_by_user(db=db, user_id=current_user.user_id, skip=skip, limit=limit)

    return bookings

@router.get("/{booking_id}", response_model=BookingResponse)
def get_booking_details(
    booking_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
) -> Any:
    """
    Get booking by ID. Ensures user can only see their own booking.
    """
    booking = db.query(Booking).filter(Booking.booking_id == booking_id).first()
    
    if not booking:
        raise HTTPException(status_code=404, detail="Booking not found")
        
    # Security check: User can only view their own bookings
    # (Unless they are an ADMIN, logic for which could be added here)
    if booking.user_id != current_user.user_id:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN, 
            detail="Not authorized to view this booking"
        )
        
    return booking