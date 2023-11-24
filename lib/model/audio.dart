import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  late AudioPlayer _audioPlayer;
String soundName = "";


  AudioManager() {
    _audioPlayer = AudioPlayer();
  }

  Future<void> playSound(String _soundName) async {
    soundName = _soundName;
    String audioPath = _getAudioPath(soundName);
    if (audioPath.isNotEmpty) {
      await _audioPlayer.setSource(AssetSource(audioPath));
      await _audioPlayer.resume();
    } else {
      print('Không tìm thấy file âm thanh cho chuỗi: $soundName');
    }
  }
  Future<void> setSoundName( String newName) async {
    soundName = newName;

  }
  Future<void> Loop() async {
    _audioPlayer.setReleaseMode(ReleaseMode.loop);

  }
  String _getAudioPath(String soundName) {
    // Xác định đường dẫn âm thanh từ chuỗi đặc biệt (soundName)
    // Ví dụ: có thể sử dụng câu lệnh switch hoặc map để ánh xạ chuỗi với đường dẫn âm thanh
    // Ví dụ đơn giản:
    switch (soundName) {
      case 'success':
        return 'audio/success.wav';
      case 'wrong':
        return 'audio/wrong.wav';
      case 'start':
        return 'audio/start.wav';
      case 'click':
        return 'audio/click.wav';
      case 'result':
        return 'audio/result.wav';
      case 'sound_track':
        return 'audio/sound_track.wav';
    // Thêm các trường hợp khác tại đây nếu cần thiết
      default:
        return '';
    }
  }

// Các hàm điều khiển khác như pause, stop, seek, setVolume, setPlaybackSpeed
  void setVolume(double volume) {
    _audioPlayer.setVolume(volume);
  }

  void stop() {
    _audioPlayer.stop();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> resume() async {
    await _audioPlayer.resume();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }




}
