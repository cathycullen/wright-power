
TeamMember.delete_all
member = TeamMember.create(name: "Adrianna Velasquez", email: "adri.r.velasquez@gmail.com")
member = TeamMember.create(name: "Cathy Cullen", email: "cathy@softwareoptions.com")
member = TeamMember.create(name: "Chiara Stermieri", email: "chiarastermieri@gmail.com")
member = TeamMember.create(name: "Don Claus", email: "don.clausjr@gmail.com")
member = TeamMember.create(name: "Julie Birch", email: "jbirch1015@gmail.com")
member = TeamMember.create(name: "Pat Lee", email: "palwwcom@gmail.com")
member = TeamMember.create(name: "Silvana Favaretto", email: "sildzn@hotmail.com")
member = TeamMember.create(name: "Stephanie Castillo", email: "sacastillo6@gmail.com")
member = TeamMember.create(name: "Yann Dang", email: "yanndang@gmail.com")
member = TeamMember.create(name: "Therese Arnaudo", email: "therese.arnaudo@oracle.com")

Attendee.delete_all
attendee = Attendee.create(name: "Mary Smith", email: "cathy@softwareoptions.com", team_member_id: 11, attending: true)
attendee = Attendee.create(name: "John Doe", email: "cathy@softwareoptions.com", team_member_id: 12, attending: false)
attendee = Attendee.create(name: "Jody Michael", email: "cathy@softwareoptions.com", team_member_id: 13, attending: true)
attendee = Attendee.create(name: "Jane Doe", email: "cathy@softwareoptions.com", team_member_id: 14, attending: false)


