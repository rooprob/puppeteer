# # Muppet Entity
#
# This is the Muppet Entity. It is responsible for the managment of Muppets
# (in the form of a Collection or a Model). They are stored under the
# `Entities` module.

@App.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  # ## Muppet Model
  #
  # Represents a single Muppet. Each of them should have a `name` an `image`
  # and a `description`, but we don't set them explicitly as defaults since
  # our data is being bootstraped for this sample application.
  class Entities.Muppet extends Entities.Model

  # ## Muppets Collection
  #
  # Represents a group of Muppets.
  class Entities.Muppets extends Entities.Collection
    model: Entities.Muppet

    # ### Filter by name
    filterByName: (text) ->

      # If no `text` is provided, returns all Models in the Collection.
      return @models if text is ""

      # Else, returns only models which contains `text` on its
      # `name` attribute (case insensitive).
      return @filter (muppet) ->
        muppetName = muppet.get("name").toUpperCase()
        return _.include muppetName, text.toUpperCase()

  # ## Sample data
  #
  # This data will bootstrap the Collection. Usually, this data would come from
  # a backend, but to simplify the application it is provided inline.
  array = []
  array.push { id: 1, name: "Walter", image: "walter.jpg", desc: "Walter is a Muppet character that first appeared in the 2011 film The Muppets. Performed by Peter Linz, he is one of the central protagonists introduced in the film. During his adolescence, Walter frequently watched The Muppet Show, collecting memorabilia and finding the cast as a source of inspiration during his upbringing, which is why he often refers to himself as the \"world’s biggest Muppet fan\". While on vacation in Los Angeles, Walter assists the Muppets in regaining both their popularity with the public and control of their acquired studios from oil baron Tex Richman. At the conclusion of the film, Walter deduces that he is a Muppet, adopts whistling as his sole talent and joins the group as their newest member." }
  array.push { id: 2, name: "Janice", image: "janice.jpg", desc: "Janice is a lead guitar player. She has blond hair, big eyelashes and lips, and usually wears a brown hat with a turquoise gem and a feather. Though she regularly performed vocals, she actually only sang lead a couple of times on the show. She also acted in sketches periodically, most notably as wisecracking Nurse Janice in \"Veterinarian's Hospital\", a recurring parody of medical dramas. Her name is an homage to Janis Joplin. Janice is the band's lead guitar player, and she plays left-handed. Her favourite guitar is a Gibson Les Paul with cherry sunburst colour scheme." }
  array.push { id: 3, name: "Zoot", image: "zoot.jpg", desc: "Zoot is a teal, balding saxophone player with dark glasses and a high-crowned blue felt hat, and was generally a laid-back fellow of few words. His name refers to the 20th century saxophonist Zoot Sims and per designer Bonnie Erickson, is modeled after Latin jazz artist Gato Barbieri. He is performed by Dave Goelz. He was conceived as a burned-out, depressed 50-year old musician, but according to Goelz, when the role was assigned to him, he did not know how to perform that type of character. He therefore made the character mainly communicate through his playing rather than by speaking." }
  array.push { id: 4, name: "Animal", image: "animal.jpg", desc: "Animal is the primitive wild man, drummer, and the most published member of the band, being the only member to have appeared in every feature film and the only member in the regular cast of the Muppet Babies spin-off cartoon. He is named for his wild behavior and drumming. Some speculate the character is based on either Keith Moon or Levon Helm while others have suggested Mick Fleetwood. In the April 8, 2002, episode of Inside the Actors Studio, Billy Joel claimed that Liberty DeVitto was the inspiration for The Muppets character Animal, but most others say there is no evidence he was based on anyone." }
  array.push { id: 5, name: "Kermit the Frog", image: "kermit.jpg", desc: "Kermit the Frog is Jim Henson's most famous Muppet creation, first introduced in 1955. He is the protagonist of many Muppet projects, most notably on The Muppet Show, and Sesame Street, as well as movies, specials, and public service announcements throughout the years. Henson originally performed Kermit until his death in May 1990; Steve Whitmire has performed Kermit since that time. He was voiced by Frank Welker in Muppet Babies and occasionally in other animation projects." }
  array.push { id: 6, name: "Rowlf the Dog", image: "rowlf.jpg", desc: "Rowlf the Dog is a Muppet character, a scruffy brown dog of indeterminate breed with a rounded black nose and long floppy ears. He was created and originally performed by Jim Henson. Rowlf is the Muppet Theatre's resident pianist, as well as one of the show's supporting cast members. Calm and wisecracking, his humor is characterized as deadpan and as such, is one of few Muppets who is rarely flustered by the show's prevalent mayhem. He is very easy going and a fan of classical music (particularly Beethoven) and musicals." }
  array.push { id: 7, name: "Miss Piggy", image: "piggy.jpg", desc: "Miss Piggy began as a minor character on The Muppet Show TV series, but gradually developed into one of the central characters of the show. She is a pig, specifically, a mangalitsa who is convinced she is destined for stardom, and nothing will stand in her way. She has a capricious nature, at times determined to convey an image of feminine charm, but suddenly flying into a violent rage (accompanied by her trademark karate chop and \"hi-yah!\") whenever she thinks someone has insulted or thwarted her. Kermit the Frog is often the target of her alternating anger and affection. When not sending him flying through the air, she often smothers him in (usually unwanted) kisses. Frank Oz assigned hooks or personalities to each Muppet. Miss Piggy's hook was a \"Truck driver wanting to be a woman\"." }
  array.push { id: 8, name: "Statler", image: "statler.jpg", desc: "Statler and Waldorf share the stage left balcony box in the Muppet Theater, and the two delight in heckling every aspect of The Muppet Show. Statler and Waldorf are especially unforgiving to Fozzie Bear. However, it is revealed in A Muppet Family Christmas that the two critics were friends with Fozzie's mother, Ma Bear. They always have the last word, with a final comment at the end of each episode." }
  array.push { id: 9, name: "Dr. Bunsen Honeydew", image: "dr_bunsen.jpg", desc: "Dr. Bunsen Honeydew is the resident scientist on The Muppet Show, and the host of the Muppet Labs sketches. In season one of The Muppet Show he worked alone, but in season two, his assistant Beaker was added to the show. Bunsen is always eager to show off his latest scientific discovery, but his excitement about progress tends to render him short-sighted. Beaker usually ends up being harmed by Dr. Honeydew's inventions. Bunsen Honeydew's name comes from the scientific instrument called the Bunsen burner, and the shape of his head, which looks like a honeydew melon." }
  array.push { id: 10, name: "Fozzie Bear", image: "fozzie.jpg", desc: "Fozzie Bear is The Muppet Show's resident comedian. He's an orange-brown, fuzzy Muppet bear who tells bad jokes, usually punctuated with his catchphrase laugh, \"Wocka wocka wocka!\" Fozzie's best friend is Kermit the Frog, although they occasionally have differences of opinion." }
  array.push { id: 11, name: "The Great Gonzo", image: "gonzo.jpg", desc: "Gonzo, formally known as \"The Great Gonzo\" or \"Gonzo the Great\", is the resident daredevil performance artiste on The Muppet Show. He is an odd looking, unclassifiable creature with blue fur, bug eyes, and a long crooked nose. He takes pride in his uniqueness and enjoys everything that he does -- no matter how painful or ill-advised it may be." }
  array.push { id: 12, name: "Beaker", image: "beaker.jpg", desc: "Beaker is the hapless assistant to Dr. Bunsen Honeydew. He is a Live-Hand Muppet who made his first appearance in Muppet Labs sketches during the second season of The Muppet Show. Kermit the Frog describes Beaker by saying \"If somebody has to get hurt, it's almost always Beaker.\"" }
  array.push { id: 13, name: "Dr. Teeth", image: "dr_teeth.jpg", desc: "Dr. Teeth is the leader of the Electric Mayhem, the house band on The Muppet Show. Originally performed by Jim Henson, Dr. Teeth plays the keyboard and is also lead singer of the band. He first appeared in The Muppet Show: Sex and Violence in 1975, and had a prominent role in Muppet productions until Henson's death in 1990." }
  array.push { id: 14, name: "Scooter", image: "scooter.jpg", desc: "Scooter serves as a \"gofer\" backstage on The Muppet Show, and appeared from the first produced episode through the end of the series. Possessing glasses with eyes embedded in the lenses and generally wearing a green track jacket, Scooter is a vaguely humanoid character of unknown heritage (as cited in Of Muppets and Men, when pressed about his family, he explained that his mother was a parrot but he didn't know about his father)." }
  array.push { id: 15, name: "Waldorf", image: "waldorf.jpg", desc: "Statler and Waldorf share the stage left balcony box in the Muppet Theater, and the two delight in heckling every aspect of The Muppet Show. Statler and Waldorf are especially unforgiving to Fozzie Bear. However, it is revealed in A Muppet Family Christmas that the two critics were friends with Fozzie's mother, Ma Bear. They always have the last word, with a final comment at the end of each episode." }

  # ## API
  #
  # Holds the methods to work with the Entity.
  API =
    getMuppet: (id) ->
      data = _.find array, (item) ->
        return item.id is +id
      return new Entities.Muppet data

    getMuppets: ->
      return new Entities.Muppets array

    getFriends: (id) ->
      # XXX a fixed set of friends
      # Filter builds up a truth table first, then a table scan
      ids = {}
      _.each [6,7,15], (item) ->
        ids[item] = true

      data = _.filter array, (item) ->
        return ids[item.id]

      return new Entities.Muppets data

  # ## Requests

  # Returns a Model instance with given `id`.
  App.reqres.setHandler "muppet:entity", (id) ->
    API.getMuppet id if id

  # Returns a Collection instance of friends for given `id`.
  App.reqres.setHandler "muppet:friends", (id) ->
    API.getFriends id if id

  # Returns a Collection instance holding all the Models.
  App.reqres.setHandler "muppet:entities", ->
    API.getMuppets()
