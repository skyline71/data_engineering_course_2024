import datetime as datetime
import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
import sys
sys.path.append('../..')

from SQLAlchemy.model.base import Base
from SQLAlchemy.model.currency import Currency
from SQLAlchemy.model.weather import Weather
from config.global_config import SQLALCHEMY_DATABASE_URI


class DatabaseSender:
    __session_local: Session()
    __currency_data: pd.DataFrame()
    __weather_data: pd.DataFrame()

    def __init__(self):
        engine = create_engine(SQLALCHEMY_DATABASE_URI)
        Base.metadata.create_all(bind=engine)
        SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
        self.__session_local = SessionLocal()

    def set_currency_data(self, data):
        self.__currency_data = data

    def set_weather_data(self, data):
        self.__weather_data = data

    def commit_currency_data(self):
        try:
            for index, record in self.__currency_data.iterrows():
                new_record = Currency(
                    currency_date=record['date'],
                    currency=record['currency'],
                    rate_USD=record['rate_to_USD']
                )
                self.__session_local.add(new_record)
            self.__session_local.commit()
        except Exception as e:
            print(e)
            return None

    def commit_weather_data(self):
        try:
            for index, record in self.__weather_data.iterrows():
                new_record = Weather(
                    city=record['city'],
                    country=record['country'],
                    localtime=record['localtime'],
                    current_temp_c=record['current_temp_c'],
                    forecast_date=record['forecast_date'],
                    forecast_temp_c=record['forecast_temp_c'],
                    wind_speed_kph=record['wind_speed_kph'],
                    condition=record['condition']
                )
                self.__session_local.add(new_record)
            self.__session_local.commit()
        except Exception as e:
            print(e)
            return None
