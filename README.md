# data app 
Xây lại app 
note: 
https://docs.google.com/document/d/1Za86BEva8bzPrN_Qs1ly0Gfu1sUHBG_9dK9zM2rYLss/edit#heading=h.mtq41j9m95sk
1. B1: Lấy hết nice widget đã tạo

2. B2: Kiến trúc: 
    1. Layer 1: (UI) presentaion:
       1. Pages: là các trang cụ thể
       2. Screen: là các template màn hình ở bên trong trang đó
       3. Widgets: là các nice widget 
       4. router: app router cho navigator 
       5. animations: các animation: loading, đồ thị,...
    2. Layer 2: (Logic)
       1. form: các loại logic form điền 
       2. medical_logic:
           - sonde_logic: 
           - TPN
       3. patient_logic:
          - profile
          - medicalMethod  
    3. Layer 3: (data)
       1. models
          1. group
          2. patient
          3. medicalMethod
          4. profile 
       2. datahouse 
          - La noi cung cap dia chi data
       3. repositories 
          - La noi nhan data tư dia chi 
          - Chuyen data tu model -> repo
          - Chuyen repo -> model.
<<<<<<< HEAD

=======
         ![kiến trúc bloc](https://user-images.githubusercontent.com/90677680/211181525-45d07893-d845-4d9a-b9ee-2affec72b4e5.png)

  
>>>>>>> 78e0034ebb011b138a9a325b0b978e568ef3376f




