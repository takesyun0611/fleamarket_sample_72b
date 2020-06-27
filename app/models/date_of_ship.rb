class DateOfShip < ActiveHash::Base
  self.data = [
    {id: 1, date_of_ship: '1日~2日で発送'},
    {id: 2, date_of_ship: '2日~3日で発送'},
    {id: 3, date_of_ship: '4日~７日で発送'}
  ]
end