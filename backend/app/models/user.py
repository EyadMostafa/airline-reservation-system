from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from app.models.base import Base

class Role(Base):
    __tablename__ = "Role"
    
    role_id = Column("RoleID", Integer, primary_key=True, index=True)
    role_name = Column("RoleName", String(50), unique=True, nullable=False)
    
    users = relationship("User", secondary="UserRole", back_populates="roles")

class User(Base):
    __tablename__ = "User"
    
    user_id = Column("UserID", Integer, primary_key=True, index=True)
    first_name = Column("FirstName", String(100), nullable=False)
    last_name = Column("LastName", String(100), nullable=False)
    email = Column("Email", String(255), unique=True, index=True, nullable=False)
    password = Column("Password", String(255), nullable=False)
    
    roles = relationship("Role", secondary="UserRole", back_populates="users")
    phones = relationship("UserPhone", back_populates="user", cascade="all, delete-orphan")
    bookings = relationship("Booking", back_populates="user")

class UserRole(Base):
    __tablename__ = "UserRole"
    
    user_id = Column("UserID", Integer, ForeignKey("User.UserID", ondelete="CASCADE"), primary_key=True)
    role_id = Column("RoleID", Integer, ForeignKey("Role.RoleID", ondelete="CASCADE"), primary_key=True)

class UserPhone(Base):
    __tablename__ = "UserPhone"
    
    phone_id = Column("PhoneID", Integer, primary_key=True, index=True)
    user_id = Column("UserID", Integer, ForeignKey("User.UserID", ondelete="CASCADE"), nullable=False)
    phone_number = Column("PhoneNumber", String(20), nullable=False)

    user = relationship("User", back_populates="phones")