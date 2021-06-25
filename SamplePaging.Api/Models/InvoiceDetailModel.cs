using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SamplePaging.Api.Models
{
    public class InvoiceDetailModel
    {
        public int InvoiceDetailsId { get; set; }
        public Nullable<int> ItemId { get; set; }
        public Nullable<int> Quantity { get; set; }
        public Nullable<double> Rate { get; set; }
        public Nullable<int> InvoiceId { get; set; }
        public string ItemName { get; set; }

    }
}