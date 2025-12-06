from pydantic import BaseModel, Field, condecimal
from datetime import time
from typing import Optional, Annotated
from decimal import Decimal

class AircraftTypeBase(BaseModel):
    type_name: str

class AircraftTypeResponse(AircraftTypeBase):
    aircraft_type_id: int
    
    class Config:
        from_attributes = True

class AircraftBase(BaseModel):
    aircraft_id: str

class AircraftCreate(AircraftBase):
    aircraft_type_id: int

class AircraftResponse(AircraftBase):
    type: AircraftTypeResponse
    
    class Config:
        from_attributes = True

class FlightRouteBase(BaseModel):
    flight_number: str = Field(..., min_length=2, max_length=10)
    origin: str = Field(..., min_length=3, max_length=5)
    destination: str = Field(..., min_length=3, max_length=5)
    base_fare: Annotated[Decimal, Field(max_digits=10, decimal_places=2)]
    estimated_duration: time = Field(..., description="Duration as HH:MM:SS")

class FlightRouteCreate(FlightRouteBase):
    pass

class FlightRouteResponse(FlightRouteBase):
    flight_route_id: int
    
    class Config:
        from_attributes = True