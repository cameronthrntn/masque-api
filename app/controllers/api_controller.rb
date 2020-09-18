class ApiController < ApplicationController
  def index
    json_response({
      "/users": {
        params: {
          access: {
            format: {
              access: "string"
            },
            function: "A unique access code for a user"
          }
        },
        GET: "Returns a user with given access code",
        POST: "Posts a new user",
        DELETE: "Deletes a given user"
      },
      "/topics":{
        params: {
          distance: {
            "closest": "Gets topics nearest the user",
            "midrange": "Gets topics within around 100 miles of the user",
            "null": "Gets topics regardless of distance"
          },
          latitude: {
            format: "float",
            function: "The latitude of the user"
          },
          longitude: { 
            format: "float",
            function: "The longitude of the user"
          },
          page: {
            format: "number", 
            function: "The offset of topics to be returned"
          },
          amount: { 
            format: "number",
            function: "The number of topics to return per page"
          }
        },
        GET: "Gets topic by location relative to user",
        POST: "Posts a new topic",
        "/:id": {
          GET: "Returns a topic by a given id",
          DELETE: "Deletes a topic by a given id",
          "/comments": {
            GET: "Returns the comments for a given topic",
            POST: "Post a new comment to a topic"
          }
        }
      }})
  end
end