class SoldOut < ActiveHash::Base
  self.data = [
    {id: 0, status: '販売中'},
    {id: 1, status: '売り切れ'}
  ]
end