from sqlalchemy.orm import Session
from app.crud.base import CRUDBase
from app.models.user import User, UserPhone, Role, UserRole
from app.schemas.user import UserCreate, UserUpdate
from app.core.security import get_password_hash

class CRUDUser(CRUDBase[User, UserCreate, UserUpdate]):
    
    def get_by_email(self, db: Session, *, email: str) -> User | None:
        return db.query(User).filter(User.email == email).first()

    def create_with_phone(self, db: Session, *, obj_in: UserCreate) -> User:
        db_obj = User(
            first_name=obj_in.first_name,
            last_name=obj_in.last_name,
            email=obj_in.email,
            password=get_password_hash(obj_in.password)
        )
        db.add(db_obj)
        db.flush()

        for phone in obj_in.phone_numbers:
            db_phone = UserPhone(user_id=db_obj.user_id, phone_number=phone)
            db.add(db_phone)

        passenger_role = db.query(Role).filter(Role.role_name == "PASSENGER").first()
        if passenger_role:
             db_role = UserRole(user_id=db_obj.user_id, role_id=passenger_role.role_id)
             db.add(db_role)

        db.commit()
        db.refresh(db_obj)
        return db_obj

user = CRUDUser(User)