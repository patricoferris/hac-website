import HaCTML

// swiftlint:disable line_length
func getEventListItem(_ event: GeneralEvent) -> Node {
  let titleText = "Title: " + event.title
  let timeText = "Time: " + event.time.debugDescription
  let tagLineText = "Tagline: " + event.tagLine
  let colorText = "Color: " + event.color
  let hypePeriodText = "Hype period: " + event.hypePeriod.description
  var tagsText = "Tags: "
  for tag in event.tags {
    tagsText = tagsText + "\(tag), "
  }
  let eventDescriptionText = "Markdown Event Description: " + event.eventDescription.raw
  let websiteURLText = "WebsiteURL: " + (event.websiteURL ?? "null")
  let imageURLText = "ImageURL: " + (event.imageURL ?? "null")
  var venue = "Venue: No Location", addr = "Address: No Location", long = "Longitude: No Location", lat = "Latitude: No Location"
    if let location = event.location {
    venue = "Venue: " + (location.venue ?? "null")
    addr = "Address: " + (location.address ?? "null")
    long = "Longitude: " + String(location.longitude)
    lat = "Latitude: " + String(location.latitude)
  }
  let facebookEventIDText = "Facebook ID: " + (event.facebookEventID ?? "null")

  return El.Div[Attr.className => "EventsPortal__eventContainer"].containing(
    El.Div.containing(titleText),
    El.Div.containing(timeText),
    El.Div.containing(tagLineText),
    El.Div.containing(colorText),
    El.Div.containing(hypePeriodText),
    El.Div.containing(tagsText),
    El.Div.containing(eventDescriptionText),
    El.Div.containing(websiteURLText),
    El.Div.containing(imageURLText),
    El.Div.containing(facebookEventIDText),
    El.Br,
    El.H3.containing("Location: "),
    El.Div.containing(venue),
    El.Div.containing(addr),
    El.Div.containing(long),
    El.Div.containing(lat),
    El.Br,
    El.Div[Attr.className => "EventsPortal__divider"].containing()
  )
}

struct EventsPage: Nodeable {

  var node: Node {

    let events = EventServer.getAllEvents()
    let eventListItems = events.map({
      (event: GeneralEvent) -> Node in 
        getEventListItem(event)
      }
    )
    let eventsNumberText = "There are " + String(eventListItems.count) + " items in the database"
    return Page(
      title: "Events",
      content: Fragment(
        El.Div[Attr.className => "EventsPortal__mainContainer"].containing([
          El.Div.containing(eventsNumberText),
          El.H1.containing("Events in Database"),
          El.Div[Attr.className => "EventsPortal__divider"].containing(),
          El.Div.containing(eventListItems)
        ])
      )
    ).node
  }
}
