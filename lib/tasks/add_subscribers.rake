desc "Adds existing subscribers."
  task add_subscribers: :environment do
    add_subscribers
  end


def add_subscribers
  coordinates = [[-3.1167, 55.6333], [139.69, 35.69], [-2.7802, 57.0755], [4.9027, 52.3666], [4.3528, 50.8466], [-90.6238, 40.412], [103.8558, 1.2931], [-1.8662, 51.7132], [-82.8981, 40.1071], [-99.1386, 19.4342]]

  coordinates.each do |coordinate|
    subscriber = Subscriber.new(longitude: coordinate[0], latitude: coordinate[1])
    subscriber.save
  end
end
