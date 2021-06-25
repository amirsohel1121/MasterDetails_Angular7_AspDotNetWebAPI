using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Cors;
using SamplePaging.Api.Models;

namespace SamplePaging.Api.Controllers
{
    [RoutePrefix("api/invoices")]
    [EnableCors("*", "*", "*")]
    public class InvoicesController : ApiController
    {
        MasterDetailsDBEntities db = new MasterDetailsDBEntities();
        public InvoicesController()
        {
        }


        [HttpGet]
        [Route("get-invoices")]
        public IHttpActionResult Getinvoices(int pageSize, int pageNumber, string searchText)
        {
            int total = 0;
            List<InvoiceModel> invoices = db.Invoices
                .Where(x =>
                (x.PONo.Contains(searchText) || string.IsNullOrEmpty(searchText)
                || (x.RefId.Contains(searchText) || string.IsNullOrEmpty(searchText)))).Select(x=>new InvoiceModel {RefId=x. RefId, PONo=x.PONo, CustomerName=x.Customer.Name, ExpectedDate=x.ExpectedDate, InvoiceId=x.InvoiceId, PODate=x.PODate,Remarks=x.Remarks, SupplierId=x.SupplierId}).ToList();
            total = invoices.Count();
            invoices = invoices.OrderBy(x => x.PONo).Skip((pageNumber - 1) * pageSize).Take(pageSize).ToList();
            return Ok(new ResponseMessage<List<InvoiceModel>>()
            {
                Result = invoices,
                Total = total
            });
        }


        [HttpPost]
        [ModelValidation]
        [Route("save-invoice")]
        public async Task<IHttpActionResult> SaveInvoice([FromBody] Invoice model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            db.Invoices.Add(model);
            await db.SaveChangesAsync();
            return Ok(new ResponseMessage<Invoice>
            {
                Result = model
            });
        }

        [HttpGet]
        [Route("get-invoice")]
        public async Task<IHttpActionResult> GetInvoice(int invoiceId)
        {
            Invoice model = invoiceId>0?await db.Invoices.FindAsync(invoiceId): new Invoice();
            var invoice = db.Invoices.OrderByDescending(x => x.InvoiceId).FirstOrDefault();
            var getMaxInvoiceNo = invoice != null ? Convert.ToInt64(invoice.PONo) + 1 : 1000;
            model.PONo =Convert.ToString(getMaxInvoiceNo);
            model.PODate = DateTime.Now;
            model.SupplierList = db.Customers.Select(x=>new SelectModel {Text=x.Name, Value=x.CustomerID }).ToList();
            model.ItemList = db.Items.Select(x=>new SelectModel { Text=x.Name, Value=x.ItemID}).ToList();
            InvoiceModel invoiceModel = new InvoiceModel
            {
                InvoiceId = model.InvoiceId,
                PODate = model.PODate,
                RefId = model.RefId,
                SupplierId = model.SupplierId,
                ExpectedDate = model.ExpectedDate,
                PONo = model.PONo,
                Remarks = model.Remarks,
                SupplierList=model.SupplierList.ToList(),
                ItemList=model.ItemList.ToList(),
                InvoiceDetails=model.InvoiceDetails.Select(x=>new InvoiceDetailModel {InvoiceDetailsId=x.InvoiceDetailsId, InvoiceId=x.InvoiceId, ItemId=x.ItemId, ItemName=x.Item.Name, Quantity=x.Quantity, Rate=x.Rate } ).ToList()

            };
            return Ok(new ResponseMessage<InvoiceModel>
            {
                Result = invoiceModel
            });


        }


        [HttpPut]
        [Route("update-invoice/{invoiceId}")]
        public async Task<IHttpActionResult> UpdateInvoice(int invoiceId, [FromBody] Invoice model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (invoiceId != model.InvoiceId)
            {
                return BadRequest();
            }

            var existinginvoice = db.Invoices
               .Where(p => p.InvoiceId == model.InvoiceId)
               .Include(p => p.InvoiceDetails)
               .SingleOrDefault();

            if (existinginvoice != null)
            {
                // Update Invoice
                db.Entry(existinginvoice).CurrentValues.SetValues(model);
                foreach (var InvoiceDetail in existinginvoice.InvoiceDetails.ToList())
                {
                    if (!model.InvoiceDetails.Any(x => x.InvoiceDetailsId == InvoiceDetail.InvoiceDetailsId))
                    {
                        db.InvoiceDetails.Remove(InvoiceDetail);
                        db.SaveChanges();
                    }

                }

                foreach (var invoicedetail in model.InvoiceDetails)
                {
                    var existingInvoiceDetail = existinginvoice.InvoiceDetails
                        .Where(c => c.InvoiceDetailsId == invoicedetail.InvoiceDetailsId)
                        .SingleOrDefault();

                    if (existingInvoiceDetail != null)
                    {
                        // Update InvoiceDetails
                        db.Entry(existingInvoiceDetail).CurrentValues.SetValues(invoicedetail);
                    }
                    else
                    {
                        existinginvoice.InvoiceDetails.Add(invoicedetail);
                    }
                    db.SaveChanges();

                }
            }

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!InvoiceExits(invoiceId))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
            return Ok(new ResponseMessage<Invoice>
            {
                Result = model

            });
        }

        private bool InvoiceExits(int invoiceId)
        {
            return db.Invoices.Count(e => e.InvoiceId == invoiceId) > 0;
        }
    }
}
