package com.example.kilo;
import io.flutter.embedding.android.FlutterActivity;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import org.tensorflow.lite.Interpreter;
import android.os.Bundle;
import java.util.ArrayList;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import android.content.res.AssetFileDescriptor;
import android.util.Log;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {
	private static final String CHANNEL = "ondeviceML";
	public Interpreter tflite;
	
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		new MethodChannel(getFlutterEngine().getDartExecutor(), CHANNEL).setMethodCallHandler(new MethodCallHandler() {
			@Override
			public void onMethodCall(MethodCall call, Result result) {
				if (call.method.equals("predictData")) {

					try {
						tflite = new Interpreter(loadModelFile(call.argument("model") + ".tflite"));
					} catch (Exception e) {
						System.out.println("Exception while loading: " + e);
						throw new RuntimeException(e);
					}
					ArrayList<Double> args = call.argument("arg");
					float prediction = predictData(args);
					if (prediction != 0) {
						result.success(prediction);
					} else {
						result.error("UNAVAILABLE", "prediction  not available.", null);
					}
				} else {
					result.notImplemented();
				}
			}
		});
	}
	
	//This method interact with our model and makes prediction returning value of
	float predictData(ArrayList<Double> input_data) {
		float inputArray[][] = new float[1][input_data.size()];
		int i = 0;
		for (Double e : input_data) {
			inputArray[0][i] = e.floatValue();
			i++;
		}
		float[][] output_data = new float[1][1];
		tflite.run(inputArray, output_data);

		Log.d("tag", ">> " + output_data[0][0]);

		return output_data[0][0];
	}

	// method to load tflite file from device
	private MappedByteBuffer loadModelFile(String modelName) throws Exception {
		AssetFileDescriptor fileDescriptor = this.getAssets().openFd(modelName);
		FileInputStream inputStream = new FileInputStream(fileDescriptor.getFileDescriptor());
		FileChannel fileChannel = inputStream.getChannel();
		long startOffset = fileDescriptor.getStartOffset();
		long declaredLength = fileDescriptor.getDeclaredLength();
		return fileChannel.map(FileChannel.MapMode.READ_ONLY, startOffset, declaredLength);
	}
}