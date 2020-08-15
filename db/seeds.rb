require 'yaml'

masks = YAML.load(File.read("config/masks.yml"))
colours = YAML.load(File.read("config/colours.yml"))

usersArr = Array.new(8)
topicsArr = Array.new(6)
masksArr =  [
  # Thread masks
  {
    user_id: 1,
    topic_id: 1,
    design: 'thief',
    colour: 'red'
  },
  {
    user_id: 1,
    topic_id: 2,
    design: 'hannya',
    colour: 'cyan'
  },{
    user_id: 2,
    topic_id: 3,
    design: 'kitsune',
    colour: 'green'
  },{
    user_id: 3,
    topic_id: 4,
    design: 'hyottoko',
    colour: 'navy'
  },{
    user_id: 4,
    topic_id: 5,
    design: 'opera',
    colour: 'yellow'
  },{
    user_id: 5,
    topic_id: 6,
    design: 'carnivale',
    colour: 'yellow'
  },

  # Comment masks
  {
    user_id: 1,
    topic_id: 3,
    design: 'festima',
    colour: 'purple'
  },{
    user_id: 6,
    topic_id: 1,
    design: 'huichol',
    colour: 'pink'
  },{
    user_id: 6,
    topic_id: 2,
    design: 'calacas',
    colour: 'orange'
  },{
    user_id: 7,
    topic_id: 1,
    design: 'tragedy',
    colour: 'red'
  },{
    user_id: 8,
    topic_id: 1,
    design: 'thief',
    colour: 'cyan'
  },{
    user_id: 4,
    topic_id: 1,
    design: 'comedy',
    colour: 'red'
  },{
    user_id: 2,
    topic_id: 2,
    design: 'hyottoko',
    colour: 'pink'
  }
]
commentsArr = Array.new(20)

def makeTopics(topicsArr, usersArr)
  topicsArr[0] = {
    title: (Faker::JapaneseMedia::OnePiece.quote).slice(0,128),
    content: Faker::JapaneseMedia::OnePiece.quote,
    user_id: 1,
  }
  num = topicsArr.length - 1
  num.times do |idx|
    topic = {
      title: (Faker::JapaneseMedia::OnePiece.quote).slice(0,128),
      content: Faker::JapaneseMedia::OnePiece.quote,
      user_id: idx + 1,
    }
    puts "added #{topic[:title]} to topics."
    topicsArr[idx + 1] = topic
  end
  puts "#{topicsArr.length} Topics added"
  return topicsArr
end

def makeUsers(arr)
  arr.each_with_index do |val, idx|
    user = {
      access: "#{Faker::JapaneseMedia::OnePiece.character.gsub(/\s+/, "")}1234123456789"
    }
    puts "added #{user[:access].reverse.slice(13...).reverse} to users."
    arr[idx] = (user)
  end
  puts "#{arr.length} Users added"
  return arr
end


def makeMasks(masksArr)
  # I had some fancy automation here but the randomness was too much of a hassle to work with so I got lazy and now you get the stupidest function in all of existence.
  puts '13 masks added.'
  return masksArr
end

def makeComments(commentsArr, masksArr)
  # The commented code here made impossible replies, would be nice to fix but I've spent too long on this seed file...
  puts '14 comments added'
  return [
    {
      content: Faker::JapaneseMedia::OnePiece.quote,
      reply_id: 0,
      mask_id: 4
    },{
      content: Faker::JapaneseMedia::OnePiece.quote,
      reply_id: 0,
      mask_id: 1
    },{
      content: Faker::JapaneseMedia::OnePiece.quote,
      reply_id: 0,
      mask_id: 8
    },{
      content: Faker::JapaneseMedia::OnePiece.quote,
      reply_id: 3,
      mask_id: 1
    },{
      content: Faker::JapaneseMedia::OnePiece.quote,
      reply_id: 4,
      mask_id: 8
    },{
      content: Faker::JapaneseMedia::OnePiece.quote,
      reply_id: 5,
      mask_id: 1
    },{
      content: Faker::JapaneseMedia::OnePiece.quote,
      reply_id: 0,
      mask_id: 10
    },{
      content: Faker::JapaneseMedia::OnePiece.quote,
      reply_id: 7,
      mask_id: 11
    },{
      content: Faker::JapaneseMedia::OnePiece.quote,
      reply_id: 0,
      mask_id: 12
    },{
      content: Faker::JapaneseMedia::OnePiece.quote,
      reply_id: 0,
      mask_id: 13
    },{
      content: Faker::JapaneseMedia::OnePiece.quote,
      reply_id: 10,
      mask_id: 2
    },{
      content: Faker::JapaneseMedia::OnePiece.quote,
      reply_id: 11,
      mask_id: 9
    },{
      content: Faker::JapaneseMedia::OnePiece.quote,
      reply_id: 0,
      mask_id: 9
    },{
      content: Faker::JapaneseMedia::OnePiece.quote,
      reply_id: 0,
      mask_id: 7
    }
  ]
  # commentsArr.each.with_index do |comment, idx|
  #   chance = rand(4)
  #   reply_id = 0
  #   if chance == 2 && idx > 2
  #     reply_id = rand(idx)
  #   end

  #   commentsArr[idx] = {
  #     content: Faker::JapaneseMedia::OnePiece.quote,
  #     reply_id: reply_id,
  #     mask_id: rand(masksArr.length) + 1
  #   }

  # end
  # puts commentsArr
  return commentsArr
end

User.create(makeUsers(usersArr))
Topic.create(makeTopics(topicsArr, usersArr))
Mask.create(makeMasks(masksArr))
Comment.create(makeComments(commentsArr, masksArr))