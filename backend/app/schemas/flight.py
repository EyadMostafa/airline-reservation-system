from pydantic import BaseModel, Field
from datetime import datetime, time
from typing import Optional, List
from app.schemas.fleet import FlightRouteResponse, AircraftResponse

class FlightBase(BaseModel):
    departure_time: datetime
    arrival_time: datetime
    flight_status: str = "Scheduled"

class FlightCreate(FlightBase):
    flight_route_id: int
    aircraft_id: str

class FlightStatusUpdate(BaseModel):
    flight_status: str

class FlightResponse(FlightBase):
    flight_id: int
    duration: time 
    
    route: FlightRouteResponse 
    aircraft: AircraftResponse

    class Config:
        from_attributes = True

class SeatStatus(BaseModel):
    seat_id: int
    seat_number: str
    seat_class: str
    is_available: bool

class SeatMapResponse(BaseModel):
    flight_id: int
    seats: List[SeatStatus]