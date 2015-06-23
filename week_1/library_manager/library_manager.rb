
class LibraryManager
  require "date"
  FINE_RATE = 0.1      #Размер пени в процентах
  FINE = FINE_RATE/100

  # 1. Бибилиотека в один момент решила ввести жесткую систему штрафов (прямо как на rubybursa :D).
  # За каждый час опоздания со здачей книги читатель вынужден заплатить пеню 0,1% от стоимости.  
  # Необходимо реализовать метод, который будет считать эту сумму в зависимости от даты выдачи и 
  # текущего времени. По работе с датой-временем информацию можно посмотреть 
  # тут http://ruby-doc.org/stdlib-2.2.2/libdoc/date/rdoc/DateTime.html
  # 
  # Входящие параметры метода 
  # - стоимость книги в центах, 
  # - дата и время возврата (момент, когда книга должна была быть сдана, в формате DateTime)
  # Возвращаемое значение 
  # - пеня в центах
  def penalty price, issue_datetime
    res = (price * FINE * (DateTime.now.new_offset(0) - issue_datetime)*24).floor
    res > 0 ? res : 0
  end

  # 2. Известны годы жизни двух писателей. Год рождения, год смерти. Посчитать, могли ли они чисто 
  # теоретически встретиться. Даже если один из писателей был в роддоме - это все равно считается встречей. 
  # Помните, что некоторые писатели родились и умерли до нашей эры - в таком случае годы жизни будут просто 
  # приходить со знаком минус.
  # 
  # Входящие параметры метода 
  # - год рождения первого писателя, 
  # - год смерти первого писателя, 
  # - год рождения второго писателя, 
  # - год смерти второго писателя.
  # Возвращаемое значение 
  # - true или false
  def could_meet_each_other? year_of_birth_first, year_of_death_first, year_of_birth_second, year_of_death_second
    year_of_birth_first > year_of_birth_second ? ( year_of_birth_first <  year_of_death_second) : ( year_of_birth_second < year_of_death_first )
  end

  # 3. Исходя из жесткой системы штрафов за опоздания со cдачей книг, читатели начали задумываться - а 
  # не дешевле ли будет просто купить такую же книгу...  Необходимо помочь читателям это выяснить. За каждый 
  # час опоздания со здачей книги читатель вынужден заплатить пеню 0,1% от стоимости.
  # 
  # Входящий параметр метода 
  # - стоимость книги в центах 
  # Возвращаемое значение 
  # - число полных дней, нак которые необходимо опоздать со здачей, чтобы пеня была равна стоимости книги.
  def days_to_buy price
    (1/FINE/24).ceil
  end


  # 4. Для удобства иностранных пользователей, имена авторов книг на украинском языке нужно переводить в 
  # транслит. Транслитерацию должна выполняться согласно официальным 
  # правилам http://kyivpassport.com/transliteratio/
  
  # Входящий параметр метода 
  # - имя и фамилия автора на украинском. ("Іван Франко") 
  # Возвращаемое значение 
  # - имя и фамилия автора транслитом. ("Ivan Franko")
  def author_translit ukr_name
    tab = { 'А'=>'A','а'=>'a','Б'=>'B','б'=>'b','В'=>'V','в'=>'v','Г'=>'H','г'=>'h',
            'Ґ'=>'G','ґ'=>'g','Д'=>'D','д'=>'d','Е'=>'E','е'=>'e','Є'=>'Ye','є'=>'ie',
            'Ж'=>'Zh','ж'=>'zh','З'=>'Z','з'=>'z','И'=>'Y','и'=>'y','І'=>'I','і'=>'i',
            'Ї'=>'Yi','ї'=>'i','Й'=>'Y','й'=>'i','К'=>'K','к'=>'k','Л'=>'L','л'=>'l',
            'М'=>'M','м'=>'m','Н'=>'N','н'=>'n','О'=>'O','о'=>'o','П'=>'P','п'=>'p',
            'Р'=>'R','р'=>'r','С'=>'S','с'=>'s','Т'=>'T','т'=>'t','У'=>'U','у'=>'u',
            'Ф'=>'F','ф'=>'f','Х'=>'Kh','х'=>'kh','Ц'=>'Ts','ц'=>'ts','Ч'=>'Ch','ч'=>'ch',
            'Ш'=>'Sh','ш'=>'sh','Щ'=>'Shch','щ'=>'shch','Ю'=>'Yu','ю'=>'iu','Я'=>'Ya',
            'я'=>'ia', '’'=>'','ь'=>''}
    res = ''
#    ukr_name.each_char {|c| res += (tab.has_key?(c) ? tab[c] : c)}
    prev = ''
    ukr_name.each_char do |c|
      if (prev == 'З' || prev == 'з') && (c == 'г') then
        res += 'gh'
      else
        res += (tab.has_key?(c) ? tab[c] : c)
      end
      prev = c
    end
    res
  end

  #5. Читатели любят дочитывать книги во что-бы то ни стало. Необходимо помочь им просчитать сумму штрафа, 
  # который придеться заплатить чтобы дочитать книгу, исходя из количества страниц, текущей страницы и 
  # скорости чтения за час.
  # 
  # Входящий параметр метода 
  # - Стоимость книги в центах
  # - DateTime сдачи книги (может быть как в прошлом, так и в будущем)
  # - Количество страниц в книге
  # - Текущая страница
  # - Скорость чтения - целое количество страниц в час.
  # Возвращаемое значение 
  # - Пеня в центах или 0 при условии что читатель укладывается в срок здачи.
  def penalty_to_finish price, issue_datetime, pages_quantity, current_page, reading_speed
    exp = DateTime.now.new_offset(0) + (pages_quantity - current_page).to_f / reading_speed / 24
    res = (price * FINE * (exp - issue_datetime)*24)
    res > 0 ? res : 0
  end

end

if __FILE__ == $0
print "Test1. Fee value is ", (LibraryManager.new.penalty(100, DateTime.parse('12.06.2015 15:40'))), "\n"
print "Test 2.1: Must be false: ", LibraryManager.new.could_meet_each_other?(1,10,12,15), "\n"
print "Test 2.2: Must be true: ", LibraryManager.new.could_meet_each_other?(1,12,10,15), "\n"
print "Test 2.3: Must be true: ", LibraryManager.new.could_meet_each_other?(1,10,2,9), "\n"
print "Test 2.4: Must be true: ", LibraryManager.new.could_meet_each_other?(1,10,-2,15), "\n"
print "Test 2.5: Must be true: ", LibraryManager.new.could_meet_each_other?(1,10,-2,3), "\n"
print "Test 2.6: Must be false: ", LibraryManager.new.could_meet_each_other?(1,10,-2,0), "\n"
puts "Test 3. Max days = #{LibraryManager.new.days_to_buy 100}"
puts "Test 4. ", LibraryManager.new.author_translit('Гнат Хоткевич')

translit_dim = [ ["Алушта", "Alushta"], ["Андрій", "Andrii"], ["Борщагівка", "Borshchahivka"], ["Борисенко", "Borysenko"], 
    ["Вінниця", "Vinnytsia"], ["Володимир", "Volodymyr"], ["Гадяч", "Hadiach"], ["Богдан", "Bohdan"], ["Згурський", "Zghurskyi"], 
    ["Ґалаґан", "Galagan"], ["Ґорґани", "Gorgany"], ["Донецьк", "Donetsk"], ["Дмитро", "Dmytro"], ["Рівне", "Rivne"], 
    ["Олег", "Oleh"], ["Есмань", "Esman"], ["Єнакієве", "Yenakiieve"], ["Гаєвич", "Haievych"], ["Короп’є", "Koropie"], 
    ["Житомир", "Zhytomyr"], ["Жанна", "Zhanna"], ["Жежелів", "Zhezheliv"], ["Закарпаття", "Zakarpattia"], 
    ["Казимирчук", "Kazymyrchuk"], ["Медвин", "Medvyn"], ["Михайленко", "Mykhailenko"], ["Іванків", "Ivankiv"], 
    ["Іващенко", "Ivashchenko"], ["Їжакевич", "Yizhakevych"], ["Кадиївка", "Kadyivka"], ["Мар’їне", "Marine"], 
    ["Йосипівка", "Yosypivka"], ["Стрий", "Stryi"], ["Олексій", "Oleksii"], ["Київ", "Kyiv"], ["Коваленко", "Kovalenko"], 
    ["Лебедин", "Lebedyn"], ["Леонід", "Leonid"], ["Миколаїв", "Mykolaiv"], ["Маринич", "Marynych"], ["Ніжин", "Nizhyn"], 
    ["Наталія", "Nataliia"], ["Одеса", "Odesa"], ["Онищенко", "Onyshchenko"], ["Полтава", "Poltava"], ["Петро", "Petro"], 
    ["Решетилівка", "Reshetylivka"], ["Рибчинський", "Rybchynskyi"], ["Суми", "Sumy"], ["Соломія", "Solomiia"], 
    ["Тернопіль", "Ternopil"], ["Троць", "Trots"], ["Ужгород", "Uzhhorod"], ["Уляна", "Uliana"], ["Фастів", "Fastiv"], 
    ["Філіпчук", "Filipchuk"], ["Харків", "Kharkiv"], ["Христина", "Khrystyna"], ["Біла Церква", "Bila Tserkva"], ["Стеценко", "Stetsenko"], 
    ["Чернівці", "Chernivtsi"], ["Шевченко", "Shevchenko"], ["Шостка", "Shostka"], ["Кишеньки", "Kyshenky"], 
    ["Щербухи", "Shcherbukhy"], ["Гоща", "Hoshcha"], ["Гаращенко", "Harashchenko"], ["Юрій", "Yurii"], 
    ["Корюківка", "Koriukivka"], ["Яготин", "Yahotyn"], ["Ярошенко", "Yaroshenko"], ["Костянтин", "Kostiantyn"], 
    ["Знам’янка", "Znamianka"], ["Феодосія", "Feodosiia"]]
0.upto(translit_dim.size-1) do |i|
  res = LibraryManager.new.author_translit(translit_dim[i][0])
  if res != translit_dim[i][1] then
    print 'Test 4 Error: ', res, ' != ', translit_dim[i][1], "\n"
  end
end



print "Test 5: ", (LibraryManager.new.penalty_to_finish 100, DateTime.parse('22.06.2015 15:40'), 254, 139, 10)
puts''
end