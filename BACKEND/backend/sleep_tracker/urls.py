# urls.py

from django.urls import path
from .views import CreateSleepLogView, GetSleepLogsByUser

urlpatterns = [
    path('sleep/add/', CreateSleepLogView.as_view(), name='add-sleep-log'),
    path('sleep/get/', GetSleepLogsByUser.as_view(), name='get-sleep-logs'),
]
