from pydantic import BaseModel, EmailStr, Field
from typing import Optional, List

class UserBase(BaseModel):
    first_name: str = Field(..., min_length=1, max_length=100)
    last_name: str = Field(..., min_length=1, max_length=100)
    email: EmailStr

class PhoneBase(BaseModel):
    phone_number: str = Field(..., min_length=7, max_length=20)

class PhoneCreate(PhoneBase):
    pass

class UserCreate(UserBase):
    password: str = Field(..., min_length=8)
    phone_numbers: List[str] = []

class UserUpdate(BaseModel):
    first_name: Optional[str] = Field(None, min_length=1, max_length=100)
    last_name: Optional[str] = Field(None, min_length=1, max_length=100)
    email: Optional[EmailStr] = None
    password: Optional[str] = Field(None, min_length=8)

class RoleResponse(BaseModel):
    role_id: int
    role_name: str
    
    class Config:
        from_attributes = True

class PhoneResponse(PhoneBase):
    phone_id: int
    
    class Config:
        from_attributes = True

class UserResponse(UserBase):
    user_id: int
    roles: List[RoleResponse] = []
    phones: List[PhoneResponse] = []

    class Config:
        from_attributes = True