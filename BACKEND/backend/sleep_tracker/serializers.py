from rest_framework import serializers
from userManagement.models import User
from .models import SleepLog   



class SleepLogSerializer(serializers.ModelSerializer):
    UserID = serializers.IntegerField(write_only=True)  # ✅ extra logic

    class Meta:
        model = SleepLog
        fields = ['id', 'UserID', 'date', 'sleep_start', 'sleep_end', 'duration']
        read_only_fields = ['duration']

    def create(self, validated_data):
        user_id = validated_data.pop('UserID')
        user = User.objects.get(UserID=user_id)
        sleep_log = SleepLog.objects.create(user=user, **validated_data)
        return sleep_log
