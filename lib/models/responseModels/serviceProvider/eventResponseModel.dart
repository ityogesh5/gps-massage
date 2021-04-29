class EventResponseModel {
  String kind;
  String etag;
  String summary;
  String updated;
  String timeZone;
  String accessRole;
  List<DefaultReminders> defaultReminders;
  String nextSyncToken;
  List<Items> items;

  EventResponseModel(
      {this.kind,
      this.etag,
      this.summary,
      this.updated,
      this.timeZone,
      this.accessRole,
      this.defaultReminders,
      this.nextSyncToken,
      this.items});

  EventResponseModel.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    summary = json['summary'];
    updated = json['updated'];
    timeZone = json['timeZone'];
    accessRole = json['accessRole'];
    if (json['defaultReminders'] != null) {
      defaultReminders = new List<DefaultReminders>();
      json['defaultReminders'].forEach((v) {
        defaultReminders.add(new DefaultReminders.fromJson(v));
      });
    }
    nextSyncToken = json['nextSyncToken'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['etag'] = this.etag;
    data['summary'] = this.summary;
    data['updated'] = this.updated;
    data['timeZone'] = this.timeZone;
    data['accessRole'] = this.accessRole;
    if (this.defaultReminders != null) {
      data['defaultReminders'] =
          this.defaultReminders.map((v) => v.toJson()).toList();
    }
    data['nextSyncToken'] = this.nextSyncToken;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DefaultReminders {
  String method;
  int minutes;

  DefaultReminders({this.method, this.minutes});

  DefaultReminders.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    minutes = json['minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    data['minutes'] = this.minutes;
    return data;
  }
}

class Items {
  String kind;
  String etag;
  String id;
  String status;
  String htmlLink;
  String created;
  String updated;
  String summary;
  String description;
  Creator creator;
  Creator organizer;
  Start start;
  Start end;
  String iCalUID;
  int sequence;
  List<Attendees> attendees;
  bool guestsCanInviteOthers;
  bool guestsCanSeeOtherGuests;
  Reminders reminders;
  String eventType;
  String location;
  bool endTimeUnspecified;
  String transparency;
  String visibility;
  bool privateCopy;
  Source source;

  Items(
      {this.kind,
      this.etag,
      this.id,
      this.status,
      this.htmlLink,
      this.created,
      this.updated,
      this.summary,
      this.description,
      this.creator,
      this.organizer,
      this.start,
      this.end,
      this.iCalUID,
      this.sequence,
      this.attendees,
      this.guestsCanInviteOthers,
      this.guestsCanSeeOtherGuests,
      this.reminders,
      this.eventType,
      this.location,
      this.endTimeUnspecified,
      this.transparency,
      this.visibility,
      this.privateCopy,
      this.source});

  Items.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'];
    status = json['status'];
    htmlLink = json['htmlLink'];
    created = json['created'];
    updated = json['updated'];
    summary = json['summary'];
    description = json['description'];
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    organizer = json['organizer'] != null
        ? new Creator.fromJson(json['organizer'])
        : null;
    start = json['start'] != null ? new Start.fromJson(json['start']) : null;
    end = json['end'] != null ? new Start.fromJson(json['end']) : null;
    iCalUID = json['iCalUID'];
    sequence = json['sequence'];
    if (json['attendees'] != null) {
      attendees = new List<Attendees>();
      json['attendees'].forEach((v) {
        attendees.add(new Attendees.fromJson(v));
      });
    }
    guestsCanInviteOthers = json['guestsCanInviteOthers'];
    guestsCanSeeOtherGuests = json['guestsCanSeeOtherGuests'];
    reminders = json['reminders'] != null
        ? new Reminders.fromJson(json['reminders'])
        : null;
    eventType = json['eventType'];
    location = json['location'];
    endTimeUnspecified = json['endTimeUnspecified'];
    transparency = json['transparency'];
    visibility = json['visibility'];
    privateCopy = json['privateCopy'];
    source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['etag'] = this.etag;
    data['id'] = this.id;
    data['status'] = this.status;
    data['htmlLink'] = this.htmlLink;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['summary'] = this.summary;
    data['description'] = this.description;
    if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
    if (this.organizer != null) {
      data['organizer'] = this.organizer.toJson();
    }
    if (this.start != null) {
      data['start'] = this.start.toJson();
    }
    if (this.end != null) {
      data['end'] = this.end.toJson();
    }
    data['iCalUID'] = this.iCalUID;
    data['sequence'] = this.sequence;
    if (this.attendees != null) {
      data['attendees'] = this.attendees.map((v) => v.toJson()).toList();
    }
    data['guestsCanInviteOthers'] = this.guestsCanInviteOthers;
    data['guestsCanSeeOtherGuests'] = this.guestsCanSeeOtherGuests;
    if (this.reminders != null) {
      data['reminders'] = this.reminders.toJson();
    }
    data['eventType'] = this.eventType;
    data['location'] = this.location;
    data['endTimeUnspecified'] = this.endTimeUnspecified;
    data['transparency'] = this.transparency;
    data['visibility'] = this.visibility;
    data['privateCopy'] = this.privateCopy;
    if (this.source != null) {
      data['source'] = this.source.toJson();
    }
    return data;
  }
}

class Creator {
  String email;
  String displayName;
  bool self;

  Creator({this.email, this.displayName, this.self});

  Creator.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    displayName = json['displayName'];
    self = json['self'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['displayName'] = this.displayName;
    data['self'] = this.self;
    return data;
  }
}

class Start {
  String dateTime;
  String timeZone;
  String date;

  Start({this.dateTime, this.timeZone, this.date});

  Start.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    timeZone = json['timeZone'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateTime'] = this.dateTime;
    data['timeZone'] = this.timeZone;
    data['date'] = this.date;
    return data;
  }
}

class Attendees {
  String email;
  bool self;
  String responseStatus;

  Attendees({this.email, this.self, this.responseStatus});

  Attendees.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    self = json['self'];
    responseStatus = json['responseStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['self'] = this.self;
    data['responseStatus'] = this.responseStatus;
    return data;
  }
}

class Reminders {
  bool useDefault;

  Reminders({this.useDefault});

  Reminders.fromJson(Map<String, dynamic> json) {
    useDefault = json['useDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['useDefault'] = this.useDefault;
    return data;
  }
}

class Source {
  String url;
  String title;

  Source({this.url, this.title});

  Source.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['title'] = this.title;
    return data;
  }
}
