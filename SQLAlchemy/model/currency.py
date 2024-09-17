from sqlalchemy import Column, Integer, VARCHAR, Date, Boolean, Float, TIMESTAMP
import sys
sys.path.append('..')

from SQLAlchemy.model.base import Base


class Currency(Base):
    __tablename__ = 'currency'
    id = Column(Integer, nullable=False, unique=True, primary_key=True, autoincrement=True)
    currency_date = Column(TIMESTAMP, nullable=False, index=True)
    currency = Column(VARCHAR(50), nullable=False)
    rate_USD = Column(Float, nullable=False)
