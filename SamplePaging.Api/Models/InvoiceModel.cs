using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SamplePaging.Api.Models
{
    public class InvoiceModel
    {

        public int InvoiceId { get; set; }
        public Nullable<int> SupplierId { get; set; }
        public string RefId { get; set; }
        public string PONo { get; set; }
        public Nullable<System.DateTime> PODate { get; set; }
        public Nullable<System.DateTime> ExpectedDate { get; set; }
        public string Remarks { get; set; }
        public string CustomerName { get; set; }
        public List<SelectModel> SupplierList { get;  set; }
        public List<SelectModel> ItemList { get;  set; }
        public List<InvoiceDetailModel> InvoiceDetails { get; set; }
    }
}