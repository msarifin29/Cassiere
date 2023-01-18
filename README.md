# CASSIERE

### Final project bootcamp Flutter Intensif CLub

### Untuk menjalankan code ini 

### step 1 :
## Buat project firebase, ikuti instruksi berikut [medium](https://medium.com/@denyocr.world/step-by-step-cara-setup-flutter-firebase-713f9187262b)

### step 2 :
## Buat project firebase storage , lalu ubah setelan menjadi seperti berikut 

 ```
 rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if true ;
    }
  }
}
```

### live demo [youtube](https://www.youtube.com/watch?v=3FQGTetwIPo)

![cassiere](https://user-images.githubusercontent.com/101007778/213193845-17cde7b1-b729-4aba-a3d6-4a0ce30acdd0.jpg)
