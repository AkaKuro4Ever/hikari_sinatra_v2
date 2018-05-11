#require_relative /controllers
#require -
#require_all - gem that you install to bring everything in.


book: [{title: ___, author: ___, genre: ___}]
"book" => attributes: [{
        "title" => "US History",
        "author" => "History"
      }]
#EXAMPLE 1
      params = {
      		  "student" => {
      		    "name" => "Vic",
      		    "grade" => "12",
      		    "courses" => [
      		      {
      		        "name" => "AP US History",
      		        "topic" => "History"
      		      },
      		      {
      		        "name" => "AP Human Geography",
      		        "topic" => "History"
      		      }
      		    ]
      		  }
      		}
          Course Name: <input type="text" name="student[courses][][name]">
        		  Course Topic: <input type="text" name="student[courses][][topic]">
        		  Course Name: <input type="text" name="student[courses][][name]">
        		  Course Topic: <input type="text" name="student[courses][][topic]">
        		  <input type="submit">
#EXAMPLE 2
  <%Pet.all.each do |pet|%>
  		 <input type="checkbox" name="owner[pet_ids][]" id="<%=pet.id%>" value="<%=pet.id%>"><%=pet.name%></input>
  <%end%>

  <label>and/or, create a new pet:</label>
  <br></br>
  <label>name:</label>
    <input  type="text" name="pet[name]" id="pet_name"></input>
  <br></br>

{"owner"=>
  {"name"=>"Adele",
  "pet_ids"=>["1", "2"]},
  "pet"=>{"name"=>""}}

#FOR BOOK/EDIT.ERB
    params = {
          "book" => {"author_ids" => [  ]}
          "pet"=>{"name"=>""}
        }
