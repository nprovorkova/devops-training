# Будут проигнорированы следующие файлы и директории на любом уровне вложенности:
1. Директории с наименованием '.terraform'
2. Файлы с расширением '.tfstate'
3. Файлы с расширением '.tfstate.*' - вместо звездочки любые символы
4. Файлы с наименованием 'crash.log' 
5. Файлы с расширением '.tfvars'
6. Файлы с наименованием 'override.tf' 
7. Файлы с наименованием 'override.tf.json'
8. Файлы с наименованиями, заканчивающимся на '_override.tf' 
9. Файлы с наименованиями, заканчивающимся на '_override.tf.json' 
10. Файлы с наименованием '.terraformrc'
11. Файлы с наименованием 'terraform.rc'  
 