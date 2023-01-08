# data app 
Xây lại app 

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
         
 [image](https://user-images.githubusercontent.com/90677680/211181495-578d760a-d942-4307-b68a-5ef48497a630.png)

  




