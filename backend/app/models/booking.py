from sqlalchemy import Column, Integer, String, DECIMAL, ForeignKey, DateTime, func, UniqueConstraint
from sqlalchemy.orm import relationship
from app.models.base import Base

class Booking(Base):
    __tablename__ = "Booking"
    
    booking_id = Column("BookingID", Integer, primary_key=True, index=True)
    user_id = Column("UserID", Integer, ForeignKey("User.UserID", ondelete="CASCADE"), nullable=False)
    booking_date = Column("BookingDate", DateTime, server_default=func.now())
    booking_status = Column("BookingStatus", String(20), default="Confirmed")
    total_cost = Column("TotalCost", DECIMAL(10, 2), nullable=False)
    
    user = relationship("User", back_populates="bookings")
    payments = relationship("Payment", back_populates="booking")
    tickets = relationship("Ticket", back_populates="booking", cascade="all, delete-orphan")

class Payment(Base):
    __tablename__ = "Payment"
    
    payment_id = Column("PaymentID", Integer, primary_key=True, index=True)
    booking_id = Column("BookingID", Integer, ForeignKey("Booking.BookingID"), nullable=False)
    amount = Column("Amount", DECIMAL(10, 2), nullable=False)
    payment_date = Column("PaymentDate", DateTime, server_default=func.now())
    payment_method = Column("PaymentMethod", String(50), nullable=False)
    payment_status = Column("PaymentStatus", String(20), nullable=False)
    transaction_id = Column("TransactionID", String(100), nullable=True)
    
    booking = relationship("Booking", back_populates="payments")

class Ticket(Base):
    __tablename__ = "Ticket"
    
    ticket_id = Column("TicketID", Integer, primary_key=True, index=True)
    booking_id = Column("BookingID", Integer, ForeignKey("Booking.BookingID", ondelete="CASCADE"), nullable=False)
    flight_id = Column("FlightID", Integer, ForeignKey("Flight.FlightID"), nullable=False)
    seat_id = Column("SeatID", Integer, ForeignKey("Seat.SeatID"), nullable=False)
    traveler_first_name = Column("TravelerFirstName", String(100), nullable=False)
    traveler_last_name = Column("TravelerLastName", String(100), nullable=False)
    ticket_price = Column("TicketPrice", DECIMAL(10, 2), nullable=False)
    
    booking = relationship("Booking", back_populates="tickets")
    flight = relationship("Flight", back_populates="tickets")
    seat = relationship("Seat", back_populates="tickets")
    
    __table_args__ = (UniqueConstraint("FlightID", "SeatID", name='_flight_seat_uc'),)