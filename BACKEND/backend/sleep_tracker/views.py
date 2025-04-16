from django.shortcuts import render,  get_object_or_404
from django.views.decorators.csrf import csrf_exempt
from django.utils import timezone
from .models import SleepLog
from django.http import JsonResponse
from .serializers import SleepLogSerializer

# Create your views here.
class CreateSleepLogView(APIView):
    def post(self, request):
        serializer = SleepLogSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse({"success": True, "data": serializer.data}, status=201)
        return JsonResponse({"success": False, "errors": serializer.errors}, status=400)

class GetSleepLogsByUser(APIView):
    def post(self, request):
        user_id = request.data.get('UserID')
        if not user_id:
            return JsonResponse({"success": False, "error": "UserID required"}, status=400)
        
        sleep_logs = SleepLog.objects.filter(user__UserID=user_id).order_by('-date')
        serializer = SleepLogSerializer(sleep_logs, many=True)
        return JsonResponse({"success": True, "data": serializer.data}, status=200)