from typing import Generator, Optional
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jose import jwt, JWTError
from pydantic import ValidationError
from sqlalchemy.orm import Session

from app.core import security
from app.core.config import settings
from app.core.database import get_db
from app.models.user import User
from app.schemas.token import TokenPayload

reusable_oauth2 = OAuth2PasswordBearer(
    tokenUrl=f"auth/login"
)

def get_current_user(
    db: Session = Depends(get_db),
    token: str = Depends(reusable_oauth2)
) -> User:
    """
    Dependency that validates the JWT token and retrieves the current user.
    """
    try:
        payload = jwt.decode(
            token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM]
        )
        token_data = TokenPayload(**payload)
    except (JWTError, ValidationError):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Could not validate credentials",
        )
        
    user_id = token_data.sub
    if user_id is None:
         raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found",
        )

    user = db.query(User).filter(User.user_id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
        
    return user

def get_current_active_user(
    current_user: User = Depends(get_current_user),
) -> User:
    # Add 'is_active' check here if you add that field to User model later
    return current_user

def check_role(required_role: str):
    """
    Dependency factory for Role-Based Access Control.
    Usage: Depends(check_role("ADMIN"))
    """
    def role_checker(current_user: User = Depends(get_current_user)):
        user_roles = [role.role_name for role in current_user.roles]
        if required_role not in user_roles:
             raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail=f"The user doesn't have enough privileges ({required_role} required)",
            )
        return current_user
    return role_checker