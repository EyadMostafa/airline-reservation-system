import uvicorn
from fastapi import FastAPI

from app.api.v1.endpoints import auth, flights, bookings

app = FastAPI()

app.include_router(auth.router, prefix="/auth", tags=["Auth"])
app.include_router(flights.router, prefix="/flights", tags=["Flights"])
app.include_router(bookings.router, prefix="/bookings", tags=["Bookings"])

def run():
    uvicorn.run("app.api.v1.main:app", reload=True)