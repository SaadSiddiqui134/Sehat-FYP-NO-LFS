
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('user/', include('userManagement.urls')),
    path('sleep/', include('sleep_tracker.urls'))
]
