using PetaPoco;

namespace AirFlow.Data.Models
{
    [TableName("cmsMember")]
    [PrimaryKey("NodeId")]
    public class UmbracoMember
    {
        public int NodeId { get; set; }

        public string Email { get; set; }

        public string LoginName { get; set; }
    }
}