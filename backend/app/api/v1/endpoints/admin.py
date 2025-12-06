from typing import Any
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.core.database import get_db
from app.crud.flight import flight as crud_flight
from app.schemas.flight import FlightCreate, FlightResponse, FlightStatusUpdate
from app.api.deps import check_role
from app.models.user import User

router = APIRouter()

@router.post("/flights", response_model=FlightResponse)
def schedule_flight(
    *,
    db: Session = Depends(get_db),
    flight_in: FlightCreate,
    current_admin: User = Depends(check_role("ADMIN"))
) -> Any:
    """
    Schedule a new flight (Admin only).
    """
    flight = crud_flight.create(db, obj_in=flight_in)
    return flight

@router.put("/flights/{flight_id}", response_model=FlightResponse)
def update_flight_status(
    *,
    db: Session = Depends(get_db),
    flight_id: int,
    status_in: FlightStatusUpdate,
    current_admin: User = Depends(check_role("ADMIN"))
) -> Any:
    """
    Update flight status (e.g. Delayed, Cancelled) (Admin only).
    """
    flight = crud_flight.get(db, id=flight_id)
    if not flight:
        raise HTTPException(status_code=404, detail="Flight not found")
    
    flight = crud_flight.update(db, db_obj=flight, obj_in=status_in)
    return flight