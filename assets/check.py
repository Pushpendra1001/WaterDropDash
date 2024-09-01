import numpy as np
import tensorflow as tf


interpreter = tf.lite.Interpreter(model_path="bottle_classification_model.tflite")
interpreter.allocate_tensors()


input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()


categories = ['Beer Bottles', 'Plastic Bottles', 'Soda Bottle', 'Water Bottle', 'Wine Bottle']

def predict_image_tflite(image_path):
    
    img = tf.keras.preprocessing.image.load_img(image_path, target_size=(224, 224))
    img_array = tf.keras.preprocessing.image.img_to_array(img)
    img_array = np.expand_dims(img_array, axis=0)
    img_array = img_array.astype(np.float32) / 255.0  

    
    interpreter.set_tensor(input_details[0]['index'], img_array)

    
    interpreter.invoke()

    
    output_data = interpreter.get_tensor(output_details[0]['index'])
    
    
    predicted_class = np.argmax(output_data[0])
    confidence = np.max(output_data[0])

    print(f"Predicted class: {categories[predicted_class]}")
    print(f"Confidence: {confidence:.2f}")

    
    for category, probability in zip(categories, output_data[0]):
        print(f"{category}: {probability:.2f}")


predict_image_tflite('bottle3.jpeg')