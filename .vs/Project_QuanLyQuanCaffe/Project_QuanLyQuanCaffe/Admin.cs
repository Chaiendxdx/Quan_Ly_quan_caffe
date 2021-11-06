using System;
using Project_QuanLyQuanCaffe;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Microsoft.Reporting.WinForms;
using Project_QuanLyQuanCaffe.DAO;
using Project_QuanLyQuanCaffe.DTO;

namespace Project_QuanLyQuanCaffe
{
    public partial class Admin : Form
    {
       

        BindingSource foodList = new BindingSource();

        BindingSource categoryList = new BindingSource();

        BindingSource tableList = new BindingSource();

        BindingSource accountList = new BindingSource();

        public Account loginAccount;

        public object USP_GetListBillByDateForReportTableAdapter { get; private set; }

        public Admin()
        {
            InitializeComponent();
            ReLoad();
        }

        
        #region methods

            List<Food> SearchFoodByName(string name)
        {
            List<Food> listFood = FoodDAO.Instance.SearchFoodByName(name);

            return listFood;
        }

         void ReLoad()
        {
            dtgvTable.DataSource = tableList;
            dtgvCategory.DataSource = categoryList;
            dtgvFood.DataSource = foodList;
            dtgvAccount.DataSource = accountList;
            LoadListBillByDate(dtpkFromDate.Value, dtpkToDate.Value);
            LoadListFood();
            LoadAccount();
            LoadCategory();
            LoadTable();
            LoadDateTimePickerBill();
            LoadCategoryIntoCombobox(cbCategory);
            AddFoodBinding();
            AddAccountBiding();
            AddCategoryBiding();
            AddTableBiding();
        }

        void AddAccountBiding()
        {
            txbUserName.DataBindings.Add(new Binding("Text", dtgvAccount.DataSource, "UserName"));
            txbDisplayName.DataBindings.Add(new Binding("Text", dtgvAccount.DataSource, "DisplayName"));
            nmAccountType.DataBindings.Add(new Binding("Value", dtgvAccount.DataSource, "Type"));
        }


        void LoadDateTimePickerBill()
        {
            DateTime today = DateTime.Now;
            dtpkFromDate.Value = new DateTime(today.Year, today.Month, 1);
            dtpkToDate.Value = dtpkFromDate.Value.AddMonths(1).AddDays(-1);
        }

        void LoadListBillByDate(DateTime checkIn, DateTime checkOut)
        {
            dtgvBill.DataSource = BillDAO.Instance.GetBillListByDate(checkIn,checkOut);

        }

        void AddFoodBinding()
        {
            txbFoodName.DataBindings.Add(new Binding("Text",dtgvFood.DataSource,"Name", true , DataSourceUpdateMode.Never));
            txbFoodID.DataBindings.Add(new Binding("Text", dtgvFood.DataSource, "ID", true, DataSourceUpdateMode.Never));
            nmFoodPrice.DataBindings.Add(new Binding("Value",dtgvFood.DataSource, "Price", true, DataSourceUpdateMode.Never));
        }

        void LoadCategoryIntoCombobox(ComboBox cb)
        {
            cb.DataSource = CategoryDAO.Instance.GetListCategory();
            cb.DisplayMember = "Name";
        }
        void LoadAccount()
        {
            accountList.DataSource = AccountDAO.Instance.GetListAccount();
        }

        void LoadListFood()
        {
            foodList.DataSource = FoodDAO.Instance.GetListFood();
        }

        void AddAccount(string userName, string displayName, int type)
        {
            if (AccountDAO.Instance.InsertAccount(userName, displayName, type))
            {
                MessageBox.Show("Thêm tài khoản thành công!");
            }
            else
            {
                MessageBox.Show("Thêm tài khoản thất bại");
            }
            LoadAccount();
        }

        void EditAccount(string userName, string displayName, int type)
        {
            if (AccountDAO.Instance.AccountUpdate(userName, displayName, type))
            {
                MessageBox.Show("Cập nhật tài khoản thành công!");
            }
            else
            {
                MessageBox.Show("Cập nhật tài khoản thất bại");
            }
            LoadAccount();
        }

        void DeleteAccount(string userName)
        {
            if (loginAccount.UserName.Equals(userName))
            {
                MessageBox.Show("Không thể xoá vì tài khoản đang sử dụng");
                return;
            }
            if (AccountDAO.Instance.DeleteAccount(userName))
            {
                MessageBox.Show("Đã xoá tài khoản!");
            }
            else
            {
                MessageBox.Show("Xoá tài khoản thất bại");
            }
            LoadAccount();
        }

        void ResetPass(string userName)
        {
            if (AccountDAO.Instance.ResetPassword(userName))
            {
                MessageBox.Show("Đã đặt lại mật khẩu về mặc định!");
            }
            else
            {
                MessageBox.Show("Đặt lại mật khẩu thất bại");
            }
            
        }

        void AddCategoryBiding()
        {
            txbCategoryID.DataBindings.Add(new Binding("Text", dtgvCategory.DataSource, "ID", true, DataSourceUpdateMode.Never));
            txbCategory.DataBindings.Add(new Binding("Text", dtgvCategory.DataSource, "Name", true, DataSourceUpdateMode.Never));
            
        }

        void LoadFoodList()
        {
            string query = "select * from food";

            dtgvFood.DataSource = DataProvider.Instance.ExecuteQuery(query);
        }
        void LoadCategory()
        {
            categoryList.DataSource = CategoryDAO.Instance.GetListCategory();
        }

        void AddTableBiding()
        {
            textBox3.DataBindings.Add(new Binding("Text", dtgvTable.DataSource, "ID", true, DataSourceUpdateMode.Never));
             txbTableName.DataBindings.Add(new Binding("Text", dtgvTable.DataSource, "Name", true, DataSourceUpdateMode.Never));
            txbTableStatus.DataBindings.Add(new Binding("Text", dtgvTable.DataSource, "Status", true, DataSourceUpdateMode.Never));
        }

        void LoadTable()
        {
            tableList.DataSource = TableDAO.Instance.LoadTableList();
        }


        #endregion

        #region events

        private void btnShowTable_Click(object sender, EventArgs e)
        {
            LoadTable();
        }

        private void btnShowFood_Click(object sender, EventArgs e)
        {
            LoadListFood();
        }
        
        private void btnShowAccount_Click(object sender, EventArgs e)
        {
            LoadAccount();
        }

        private void btnShowCategory_Click(object sender, EventArgs e)
        {
            LoadCategory();
        }
        private void btnSearchFood_Click(object sender, EventArgs e)
        {
           foodList.DataSource=  SearchFoodByName(txbSearchFoodName.Text);
        }
        private void txbFoodID_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (dtgvFood.SelectedCells.Count > 0)
                {
                    int id = (int)dtgvFood.SelectedCells[0].OwningRow.Cells["CategoryID"].Value;

                    Category category = CategoryDAO.Instance.GetCategoryByID(id);

                    cbCategory.SelectedItem = category;

                    int index = -1;
                    int i = 0;
                    foreach (Category item in cbCategory.Items)
                    {
                        if (item.ID == category.ID)
                        {
                            index = i;
                            break;
                        }
                        i++;
                    }
                    cbCategory.SelectedIndex = index;
                }
            }
            catch { }
        }

        private void btnAddFood_Click(object sender, EventArgs e)
        {
            string name = txbFoodName.Text;
            int categoryID = (cbCategory.SelectedItem as Category).ID;
            float price = (float)nmFoodPrice.Value;

            if (FoodDAO.Instance.InsertFood(name, categoryID, price))
            {
                MessageBox.Show("Thêm món thành công!");
                LoadListFood();
                if (insertFood != null)
                    insertFood(this, new EventArgs());
            }

            else
            {
                MessageBox.Show("Có lỗi khi thêm thức ăn");
            }
        }

        private void btnEditFood_Click(object sender, EventArgs e)
        {
            string name = txbFoodName.Text;
            int categoryID = (cbCategory.SelectedItem as Category).ID;
            float price = (float)nmFoodPrice.Value;
            int id = Convert.ToInt32(txbFoodID.Text);

            if (FoodDAO.Instance.UpdateFood(id, name, categoryID, price))
            {
                MessageBox.Show("Cập nhật món thành công!");
                LoadListFood();
                if (updateFood != null)
                    updateFood(this, new EventArgs()); 
            }

            else
            {
                MessageBox.Show("Có lỗi khi cập nhật thức ăn");
            }
        }

        private void btnDeleteFood_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(txbFoodID.Text);

            if (FoodDAO.Instance.DeleteFood(id))
            {
                MessageBox.Show("Xoá món thành công!");
                LoadListFood();
                if (deleteFood != null)
                    deleteFood(this, new EventArgs());
            }

            else
            {
                MessageBox.Show("Có lỗi khi xoá thức ăn");
            }
        }

        private void btnViewBill_Click_Click(object sender, EventArgs e)
        {
            LoadListBillByDate(dtpkFromDate.Value, dtpkToDate.Value);
        }

        private void btnAddCategory_Click(object sender, EventArgs e)
        {
            string name = txbCategory.Text;
            
            
            if (CategoryDAO.Instance.InsertCategory(name))
           {
                MessageBox.Show("Thêm thành công!");
                LoadCategory();
                if (insertCategory != null)
                    insertCategory(this, new EventArgs());
            }

            else
            {
                MessageBox.Show("Có lỗi khi thêm loại đồ ăn");
            }
       }

        private void btnDeleteCategory_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(txbCategoryID.Text);

            if (CategoryDAO.Instance.DeleteCategory(id))
            {
                MessageBox.Show("Xoá thành công!");
                LoadCategory();
                if (deleteCategory != null)
                    deleteCategory(this, new EventArgs());
            }

            else
            {
                MessageBox.Show("Có lỗi khi thực hiện");
            }
        }

        private void btnEditCategory_Click(object sender, EventArgs e)
        {
            string name = txbCategory.Text;

            int id = Convert.ToInt32(txbCategoryID.Text);

            if (CategoryDAO.Instance.UpdateCategory(name, id))
            {
                MessageBox.Show("Cập nhật thành công!");
                LoadCategory();
                if (updateCategory != null)
                    updateCategory(this, new EventArgs());
            }

            else
            {
                MessageBox.Show("Có lỗi khi cập nhật");
            }
        }

        private void btnAddTable_Click(object sender, EventArgs e)
        {

            string name = txbTableName.Text;
            int id = Convert.ToInt32(textBox3.Text);

            if (TableDAO.Instance.InsertTable(name))
            {
                MessageBox.Show("Thêm bàn ăn thành công!");
                LoadTable();
                if (insertTable != null)
                    insertTable(this, new EventArgs());
            }

            else
            {
                MessageBox.Show("Có lỗi khi thêm bàn ăn");
            }
        }

        private void btnDeleteTable_Click(object sender, EventArgs e)
        {

            int id = Convert.ToInt32(textBox3.Text);

            if (TableDAO.Instance.DeleteTable(id))
            {
                MessageBox.Show("Xoá bàn thành công!");
                LoadTable();
                if (deleteTable != null)
                    deleteTable(this, new EventArgs());
            }

            else
            {
                MessageBox.Show("Có lỗi khi thực hiện");
            }

        }

        private void btnEditTable_Click(object sender, EventArgs e)
        {
            string name = txbTableName.Text;
            

            int id = Convert.ToInt32(textBox3.Text);

            if (TableDAO.Instance.UpdateTable(name, id))
            {
                MessageBox.Show("Cập nhật thành công!");
                LoadTable();
                if (updateTable != null)
                    updateTable(this, new EventArgs());
            }

            else
            {
                MessageBox.Show("Có lỗi khi cập nhật");
            }
        }

        private void btnAddAccount_Click(object sender, EventArgs e)
        {
            string userName = txbUserName.Text;
            string displayName = txbDisplayName.Text;
            int type = (int)nmAccountType.Value;

            AddAccount(userName, displayName, type);
        }

       private void btnDeleteAccount_Click(object sender, EventArgs e)
        {
            string userName = txbUserName.Text;

            DeleteAccount(userName);
        }

        private void btnEditAccount_Click(object sender, EventArgs e)
        {
            string userName = txbUserName.Text;
            string displayName = txbDisplayName.Text;
            int type = (int)nmAccountType.Value;

            EditAccount(userName, displayName, type);
        }

        private void btnResetPassword_Click(object sender, EventArgs e)
        {
            string userName = txbUserName.Text;

            ResetPass(userName);

        }



        private event EventHandler insertTable;
        public event EventHandler InsertTable
        {
            add { insertTable += value; }
            remove { insertTable -= value; }
        }

        private event EventHandler deleteTable;
        public event EventHandler DeleteTable
        {
            add { deleteTable += value; }
            remove { deleteTable -= value; }
        }

        private event EventHandler updateTable;
        public event EventHandler UpdateTable
        {
            add { updateTable += value; }
            remove { updateTable -= value; }
        }

        private event EventHandler insertCategory;
        public event EventHandler InsertCategory
        {
            add { insertCategory += value; }
            remove { insertCategory -= value; }
        }

        private event EventHandler deleteCategory;
        public event EventHandler DeleteCategory
        {
            add { deleteCategory += value; }
            remove { deleteCategory -= value; }
        }

        private event EventHandler updateCategory;
        public event EventHandler UpdateCategory
        {
            add { updateCategory += value; }
            remove { updateCategory -= value; }
        }

        private event EventHandler insertFood;

        public event EventHandler InsertFood
        {
            add { insertFood += value; }
            remove { insertFood -= value; }
        }

        private event EventHandler deleteFood;

        public event EventHandler DeleteFood
        {
            add { deleteFood += value; }
            remove { deleteFood -= value; }
        }

        private event EventHandler updateFood;

        public event EventHandler UpdateFood
        {
            add { updateFood += value; }
            remove { updateFood -= value; }
        }

        #endregion



        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void panel4_Paint(object sender, PaintEventArgs e)
        {

        }

        private void panel6_Paint(object sender, PaintEventArgs e)
        {

        }

        private void panel3_Paint(object sender, PaintEventArgs e)
        {

        }

        private void panel5_Paint(object sender, PaintEventArgs e)
        {

        }

        

        private void tpTable_Click(object sender, EventArgs e)
        {

        }

        

        
        private void dtgvCategory_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void btnFirstBillPage_Click(object sender, EventArgs e)
        {
            txbNumberPage.Text = "1";
        }

        private void btnLastBillPage_Click(object sender, EventArgs e)
        {
            int sumRecord = BillDAO.Instance.GetNumBillListByDate(dtpkFromDate.Value, dtpkToDate.Value);

            int lastPage = sumRecord / 10;
            if(sumRecord %10 != 0)
            {
                lastPage++;
            }
            txbNumberPage.Text = lastPage.ToString();
        }

        private void txbNumberPage_TextChanged(object sender, EventArgs e)
        {
            dtgvBill.DataSource = BillDAO.Instance.GetBillListByDateAndPage(dtpkFromDate.Value, dtpkToDate.Value , Convert.ToInt32(txbNumberPage.Text));


        }

        private void btnPreBillPage_Click(object sender, EventArgs e)
        {
            int page = Convert.ToInt32(txbNumberPage.Text);
            if (page > 1) page--;
            txbNumberPage.Text = page.ToString();
        }

        private void btnNextBillPage_Click(object sender, EventArgs e)
        {
            int page = Convert.ToInt32(txbNumberPage.Text);
            int sumRecord = BillDAO.Instance.GetNumBillListByDate(dtpkFromDate.Value, dtpkToDate.Value);
            if (page < sumRecord) page++;
            txbNumberPage.Text = page.ToString();

        }

     



        

      
    }
}
    