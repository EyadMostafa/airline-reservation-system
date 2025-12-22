# app/api/v1/endpoints/flights.py
from typing import Any, List
from datetime import date
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.core.database import get_db
from app.crud.flight import flight as crud_flight
from app.schemas.flight import FlightResponse, SeatMapResponse

router = APIRouter()

@router.get("/", response_model=List[FlightResponse])
def search_flights(
    origin: str = None,
    destination: str = None,
    date: date = None,
    db: Session = Depends(get_db),
) -> Any:
    """
    Search for flights by Origin, Destination, and Departure Date.
    """
    flights = crud_flight.search_flights(
        db, origin=origin, destination=destination, departure_date=date
    )
    return flights

@router.get("/{flight_id}", response_model=FlightResponse)
def get_flight_details(
    flight_id: int,
    db: Session = Depends(get_db),
) -> Any:
    """
    Get details of a specific flight.
    """
    flight = crud_flight.get(db, id=flight_id)
    if not flight:
        raise HTTPException(status_code=404, detail="Flight not found")
    return flight

@router.get("/{flight_id}/seats", response_model=SeatMapResponse)
def get_flight_seats(
    flight_id: int,
    db: Session = Depends(get_db),
) -> Any:
    """
    Get seat map and availability for a specific flight.
    """
    seats = crud_flight.get_seat_availability(db, flight_id=flight_id)
    if not seats:
        raise HTTPException(status_code=404, detail="Flight not found")
        
    return {"flight_id": flight_id, "seats": seats}