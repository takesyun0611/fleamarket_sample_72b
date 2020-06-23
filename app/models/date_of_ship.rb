class DateOfShip < ActiveHash::Base
  self.data = [
    {id: 1, date: '1~2日で発送'},
    {id: 2, date: '3~4日で発送'},
    {id: 3, date: '5~7日で発送'}
  ]
end