# app/schemas/booking.py
from pydantic import BaseModel, condecimal
from datetime import datetime
from typing import List, Optional

# --- Nested Response Components ---

class FlightSummary(BaseModel):
    flight_number: str
    origin: str
    destination: str
    departure_time: datetime
    
    class Config:
        from_attributes = True

class TicketDetail(BaseModel):
    seat_number: str
    traveler_first_name: str
    traveler_last_name: str
    
    class Config:
        from_attributes = True

class TicketResponse(BaseModel):
    ticket_id: int
    seat_id: int
    traveler_first_name: str
    traveler_last_name: str
    ticket_price: float

    class Config:
        from_attributes = True

# --- Input Schemas ---

class TravelerRequest(BaseModel):
    seat_id: int
    traveler_first_name: str
    traveler_last_name: str

class BookingRequest(BaseModel):
    user_id: int
    flight_id: int
    selected_seats: List[TravelerRequest]
    payment_method: str = "Credit Card"

class BookingUpdate(BaseModel):
    booking_status: Optional[str] = None

# --- Main Booking Responses ---

class BookingResponse(BaseModel):
    booking_id: int
    total_cost: float
    booking_status: str
    user_id: int
    booking_date: datetime
    
    flight: Optional[FlightSummary] = None 
    tickets: List[TicketDetail] = []

    class Config:
        from_attributes = True