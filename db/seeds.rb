require 'yaml'

masks = YAML.load(File.read("config/masks.yml"))
colours = YAML.load(File.read("config/colours.yml"))

usersNum = 5
topicsNum = 7
masksNum = 25

def makeTopics(num, usersNum)
  topicsArr = []
  num.times do |topic, index| 
    topic = {
      title: (Faker::JapaneseMedia::OnePiece.quote).slice(0,255),
      content: Faker::JapaneseMedia::OnePiece.quote,
      user_id: rand(usersNum) + 1,
    }
    puts "added #{topic[:title]} to topics."
    topicsArr.push(topic)
  end
  puts "#{topicsArr.length} Topics added"
  return topicsArr
end

def makeUsers(num)
  usersArr = []
  num.times do
    user = {
      access: "#{Faker::JapaneseMedia::OnePiece.character}1234123456789"
    }
    puts "added #{user[:access].reverse.slice(13...).reverse} to users."
    usersArr.push(user)
  end
  puts "#{usersArr.length} Users added"
  return usersArr
end


def makeMasks(masks, colours, masksNum, usersNum, topicsNum)
  masksArr = []
  userTopicArr = []
  maskColourArr = []
  masksNum.times do |mask, index|

    user_id = rand(usersNum) + 1
    topic_id = rand(topicsNum) + 1
    userTopic = "#{user_id}#{topic_id}"
    mask = masks.sample
    colour = colours.sample
    maskColour = "#{mask}#{colour}#{topic_id}"

    while(userTopicArr.include?(userTopic) || maskColourArr.include?(maskColour))
      user_id = rand(usersNum) + 1
      topic_id = rand(topicsNum) + 1
      mask = masks.sample
      colour = colours.sample
      userTopic = "#{user_id}#{topic_id}"
      maskColour = "#{mask}#{colour}#{topic_id}"
    end

    userTopicArr.push(userTopic)
    maskColourArr.push(maskColour)

    mask = {
      user_id: user_id,
      topic_id: topic_id,
      mask: mask,
      colour: colour
    }

    masksArr.push(mask)
    puts "User #{mask[:user_id]} has donned a #{mask[:colour]} #{mask[:mask]} mask in topic #{mask[:topic_id]}."
  end

  puts "#{masksArr.length} masks added"
  return masksArr
end

User.create(makeUsers(usersNum))
Topic.create(makeTopics(topicsNum, usersNum))
Mask.create(makeMasks(masks, colours, masksNum, usersNum, topicsNum))