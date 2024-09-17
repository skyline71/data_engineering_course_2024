from sqlalchemy import Column, Integer, VARCHAR, Date, Boolean, Float, TIMESTAMP
import sys
sys.path.append('..')

from SQLAlchemy.model.base import Base


class Weather(Base):
    __tablename__ = 'weather'
    id = Column(Integer, nullable=False, unique=True, primary_key=True, autoincrement=True)
    city = Column(VARCHAR(50), nullable=False)
    country = Column(VARCHAR(50), nullable=False)
    localtime = Column(TIMESTAMP, nullable=False, index=True)
    current_temp_c = Column(Float, nullable=False)
    forecast_date = Column(Date, nullable=False)
    forecast_temp_c = Column(Float, nullable=False)
    wind_speed_kph = Column(Float, nullable=False)
    condition = Column(VARCHAR(50), nullable=False)
