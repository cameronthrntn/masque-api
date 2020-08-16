require 'yaml'

masks = YAML.load(File.read("config/masks.yml"))
colours = YAML.load(File.read("config/colours.yml"))

usersArr = Array.new(25)
topicsArr = Array.new(50)
masksArr =  []
commentsArr = Array.new(20)

def makeTopics(topicsArr, usersArr)
  topicsArr.each_with_index do |val, idx|
    if idx < 12
      latitude = -106.018
      longitude = 34.542
      user_id = 1
    elsif idx >= 12 && idx < 35
      latitude = ('%.3f' % (rand() * (-108.863 - -103.381) -103.381)) * 1
      longitude = ('%.3f' % (rand() * (36.870 - 31.952) + 31.952)) * 1
      user_id = 2
    else
      latitude =  ('%.3f' % (rand() * (180.000 - -180.000) - 180.000)) * 1
      longitude = ('%.3f' % (rand() * (85.000 - -85.000) + - 85.000)) * 1
      user_id = 3
    end
    topic = {
      title: (Faker::JapaneseMedia::OnePiece.quote).slice(0,128),
      content: Faker::JapaneseMedia::OnePiece.quote,
      latitude: latitude,
      longitude: longitude,
      user_id: user_id,
    }
    puts "topic: #{idx + 1}, owner: #{topic[:user_id]}"
    topicsArr[idx] = topic
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


def makeMasks(masksArr, masks, colours, topicsArr)
  topicsArr.each.with_index do |val, idx|
    if idx < 12
      user_id = 1
    elsif idx >= 12 && idx < 35
      user_id = 2
    else
      user_id = 3
    end
    mask = {
      user_id: user_id,
      topic_id: idx + 1,
      design: masks.sample,
      colour: colours.sample
    }
    puts mask
    masksArr.push(mask)
  end
  puts "#{masksArr.length} Masks added"
  return masksArr
end

def makeComments(commentsArr, masksArr, usersArr, topicsArr, masks, colours)
  num = commentsArr.length
  num.times do |idx|
    mask = {
      user_id: rand(usersArr.length) + 1,
      topic_id: rand(topicsArr.length) + 1,
      design: masks.sample,
      colour: colours.sample
    }
    puts mask
    Mask.create(mask)
    masksArr.push(mask)
    comment = {
      content: Faker::JapaneseMedia::OnePiece.quote,
      reply_id: 0,
      mask_id: masksArr.length
    }
    puts "reply: #{comment[:reply_id]}, mask: #{comment[:mask_id]}"
    commentsArr[idx] = comment
  end
  return commentsArr
end

User.create(makeUsers(usersArr))
Topic.create(makeTopics(topicsArr, usersArr))
Mask.create(makeMasks(masksArr, masks, colours, topicsArr))
Comment.create(makeComments(commentsArr, masksArr, usersArr, topicsArr, masks, colours))