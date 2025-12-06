# app/crud/crud_booking.py
from typing import List
from sqlalchemy.orm import Session
from app.crud.base import CRUDBase
from app.models.booking import Booking
from app.schemas.booking import BookingRequest, BookingUpdate

class CRUDBooking(CRUDBase[Booking, BookingRequest, BookingUpdate]):
    
    def get_multi_by_user(
        self, db: Session, *, user_id: int, skip: int = 0, limit: int = 100
    ) -> List[Booking]:
        return (
            db.query(self.model)
            .filter(Booking.user_id == user_id)
            .offset(skip)
            .limit(limit)
            .all()
        )

booking = CRUDBooking(Booking)