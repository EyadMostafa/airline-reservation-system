import os
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    PROJECT_NAME: str = "Airline Reservation System"
    API_V1_STR: str = "/api/v1"
    
    SECRET_KEY: str = os.getenv("SECRET_KEY")
    ACCESS_TOKEN_EXPIRE_MINUTES: int = int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES", 30))
    ALGORITHM: str = os.getenv("ALGORITHM", "HS256")
    
    DATABASE_URL: str = os.getenv("DATABASE_URL")

    class Config:
        case_sensitive = True
        env_file = ".env"

settings = Settings()