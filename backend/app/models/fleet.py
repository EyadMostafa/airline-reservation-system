from sqlalchemy import Column, Integer, String, DECIMAL, ForeignKey, Time, DateTime, UniqueConstraint
from sqlalchemy.orm import relationship
from app.models.base import Base

class AircraftType(Base):
    __tablename__ = "AircraftType"
    
    aircraft_type_id = Column("AircraftTypeID", Integer, primary_key=True, index=True)
    type_name = Column("TypeName", String(50), unique=True, nullable=False)
    
    aircrafts = relationship("Aircraft", back_populates="type")
    seats = relationship("Seat", back_populates="type", cascade="all, delete-orphan")

class Aircraft(Base):
    __tablename__ = "Aircraft"
    
    aircraft_id = Column("AircraftID", String(20), primary_key=True)
    aircraft_type_id = Column("AircraftTypeID", Integer, ForeignKey("AircraftType.AircraftTypeID", onupdate="CASCADE"), nullable=False)
    
    type = relationship("AircraftType", back_populates="aircrafts")
    flights = relationship("Flight", back_populates="aircraft")

class Seat(Base):
    __tablename__ = "Seat"
    
    seat_id = Column("SeatID", Integer, primary_key=True, index=True)
    aircraft_type_id = Column("AircraftTypeID", Integer, ForeignKey("AircraftType.AircraftTypeID", ondelete="CASCADE"), nullable=False)
    seat_number = Column("SeatNumber", String(5), nullable=False)
    seat_class = Column("SeatClass", String(20), nullable=False)
    
    type = relationship("AircraftType", back_populates="seats")
    tickets = relationship("Ticket", back_populates="seat")

    __table_args__ = (UniqueConstraint("AircraftTypeID", "SeatNumber", name="_aircraft_seat_"),)

class FlightRoute(Base):
    __tablename__ = "FlightRoute"
    
    flight_route_id = Column("FlightRouteID", Integer, primary_key=True, index=True)
    flight_number = Column("FlightNumber", String(10), nullable=False)
    origin = Column("Origin", String(5), nullable=False)
    destination = Column("Destination", String(5), nullable=False)
    base_fare = Column("BaseFare", DECIMAL(10, 2), nullable=False)
    estimated_duration = Column("EstimatedDuration", Time, nullable=False)
    
    flights = relationship("Flight", back_populates="route")

class Flight(Base):
    __tablename__ = "Flight"
    
    flight_id = Column("FlightID", Integer, primary_key=True, index=True)
    flight_route_id = Column("FlightRouteID", Integer, ForeignKey("FlightRoute.FlightRouteID"), nullable=False)
    aircraft_id = Column("AircraftID", String(20), ForeignKey("Aircraft.AircraftID"), nullable=False)
    departure_time = Column("DepartureTime", DateTime, nullable=False)
    arrival_time = Column("ArrivalTime", DateTime, nullable=False)
    flight_status = Column("FlightStatus", String(20), default="Scheduled")
    
    route = relationship("FlightRoute", back_populates="flights")
    aircraft = relationship("Aircraft", back_populates="flights")
    tickets = relationship("Ticket", back_populates="flight")

    @property
    def duration(self):
        return self.route.estimated_duration if self.route else None

    @property
    def flight_number(self):
        return self.route.flight_number if self.route else None
    
    @property
    def origin(self):
        return self.route.origin if self.route else None

    @property
    def destination(self):
        return self.route.destination if self.route else None