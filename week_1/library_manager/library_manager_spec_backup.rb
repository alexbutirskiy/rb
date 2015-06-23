require './library_manager.rb'
require 'active_support/all'

describe LibraryManager do

  it 'should return penalty' do
    two_days_ago = DateTime.now.new_offset(0) - 48.hours
    price_in_cent = 1400

    res = LibraryManager.new.penalty(price_in_cent, two_days_ago)

    expect(res).to eq 67

    two_days_after = DateTime.now.new_offset(0) + 48.hours
    res = LibraryManager.new.penalty(price_in_cent, two_days_after)
    expect(res).to eq 0
  end


  it 'should return possibilyty of meeting' do
    res = LibraryManager.new.could_meet_each_other?(1234, 1256, 1876, 1955)

    expect(res).to eq false

    res = LibraryManager.new.could_meet_each_other?(1234, 1256, 1235, 1245)

    expect(res).to eq true

    res = LibraryManager.new.could_meet_each_other?(1234, 1256, 1200, 1235)

    expect(res).to eq true

    res = LibraryManager.new.could_meet_each_other?(1234, 1256, 1256, 1294)

    expect(res).to eq false

    res = LibraryManager.new.could_meet_each_other?(1234, 1256, 1200, 1234)

    expect(res).to eq false
  end


  it 'should return days to buy for particular book with price' do
    price_in_cent = 1400

    res = LibraryManager.new.days_to_buy(price_in_cent)

    expect(res).to eq 42 # The result is always 41.6 ~ 42.
  end


  it 'should return name in transliteration' do
    author_name = "Гнат Хоткевич"
    test_dim = [ ["Алушта", "Alushta"], ["Андрій", "Andrii"], ["Борщагівка", "Borshchahivka"], ["Борисенко", "Borysenko"], 
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

    res = LibraryManager.new.author_translit(author_name)

    expect(res).to eq 'Hnat Khotkevych'

    0.upto(test_dim.size-1) do |i|
      res = LibraryManager.new.author_translit(test_dim[i][0])
      expect(res).to eq test_dim[i][1]
    end

  end


  it 'should return penalty to finish reading' do
    twenty_days_from_now = DateTime.now.new_offset(0) + 480.hours
    price_in_cent = 1400
    pages_quantity = 348
    current_page = 25
    reading_speed = 5

    res = LibraryManager.new.penalty_to_finish(price_in_cent, twenty_days_from_now, pages_quantity, current_page, reading_speed)

    expect(res).to eq 0
  end

end
