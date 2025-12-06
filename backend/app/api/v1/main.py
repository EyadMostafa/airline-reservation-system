import uvicorn
from fastapi import FastAPI

from app.api.v1.endpoints import auth, flights, bookings, admin

app = FastAPI()

app.include_router(auth.router, prefix="/auth", tags=["Auth"])
app.include_router(flights.router, prefix="/flights", tags=["Flights"])
app.include_router(bookings.router, prefix="/bookings", tags=["Bookings"])
app.include_router(admin.router, prefix="/admin", tags=["Admin"])

def run():
    uvicorn.run("app.api.v1.main:app", reload=True)