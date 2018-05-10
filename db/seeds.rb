AdminUser.create!(
  email: 'kevin@getbonnie.com',
  password: 'totototo',
  password_confirmation: 'totototo'
)
AdminUser.create!(
  email: 'olivier@getbonnie.com',
  password: 'totototo',
  password_confirmation: 'totototo'
)
AdminUser.create!(
  email: 'fred@getbonnie.com',
  password: 'totototo',
  password_confirmation: 'totototo'
)
AdminUser.create!(
  email: 'yohan@getbonnie.com',
  password: 'totototo',
  password_confirmation: 'totototo'
)

Category.create!(name: 'Culture', color: '#C17AFF', status: :active)
Category.create!(name: 'Sport', color: '#2CDC6B', status: :active)
Category.create!(name: 'Travel', color: '#3BABF1', status: :active)
Category.create!(name: 'Love', color: '#FE54A0', status: :active)
Category.create!(name: 'Food', color: '#FFCC00', status: :active)
Category.create!(name: 'Tech', color: '#00D1FF', status: :active)
Emotion.create!(name: 'Laughing', status: :active)
Emotion.create!(name: 'Angry', status: :active)
Emotion.create!(name: 'Sad', status: :active)
Emotion.create!(name: 'Surprised', status: :active)
Emotion.create!(name: 'Disgusted', status: :active)
Emotion.create!(name: 'Like', status: :active)
Emotion.create!(name: 'Love', status: :active)
