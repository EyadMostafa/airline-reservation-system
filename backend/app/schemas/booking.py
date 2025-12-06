from pydantic import BaseModel, condecimal
from datetime import datetime
from typing import List, Optional

# --- Nested Schemas (Used inside Booking) ---

class TravelerRequest(BaseModel):
    seat_id: int
    traveler_first_name: str
    traveler_last_name: str

class TicketResponse(BaseModel):
    ticket_id: int
    seat_id: int
    traveler_first_name: str
    traveler_last_name: str
    ticket_price: float # or Decimal

    class Config:
        from_attributes = True

# --- Booking Creation (Input) ---

class BookingRequest(BaseModel):
    user_id: int
    flight_id: int
    
    selected_seats: List[TravelerRequest]
    payment_method: str = "Credit Card"

# --- Booking Update (Input) ---
class BookingUpdate(BaseModel):
    booking_status: Optional[str] = None
    # potentially allow updating other fields

# --- Booking Response (Output) ---

class BookingResponse(BaseModel):
    booking_id: int
    user_id: int
    booking_date: datetime
    booking_status: str
    total_cost: float
    
    # can include tickets nested in the response
    tickets: List[TicketResponse] = []

    class Config:
        from_attributes = True

class BookingSummary(BaseModel):
    booking_id: int
    booking_date: datetime
    booking_status: str
    total_cost: float

    class Config:
        from_attributes = True