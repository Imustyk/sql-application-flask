document.addEventListener("DOMContentLoaded", function() {
    // Обработчик формы создания заказа
    document.getElementById("createOrderForm").addEventListener("submit", function(event) {
        event.preventDefault();
        const orderData = {
            IdCustomer: document.getElementById("IdCustomer").value,
            IdRestaurant: document.getElementById("IdRestaurant").value,
            OrderTime: document.getElementById("OrderTime").value,
            DeliveryTimeForecast: document.getElementById("DeliveryTimeForecast").value,
            IdCourier: document.getElementById("IdCourier").value
        };

        if (validateFormData(orderData)) {
            createOrder(orderData);
        }
    });

    // Загрузка списка заказов при загрузке страницы
    loadOrders();
});


// Функция для валидации данных формы
function validateFormData(formData) {
    if (isNaN(formData.IdCustomer) || formData.IdCustomer.trim() === '') {
        alert("ID клиента должен быть числом.");
        return false;
    }
    return true;
}

// Функция для создания заказа
function createOrder(formData) {
    fetch('/create_order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData)
    })
    .then(response => response.json())
    .then(data => {
        if (data.message) {
            alert("Заказ успешно создан!");
            loadOrders(); // Обновление списка заказов
        } else if (data.error) {
            alert("Ошибка при создании заказа: " + data.error);
        }
    })
    .catch(error => {
        alert("Ошибка: " + error);
    });

}

// Функция для загрузки и отображения списка заказов
function loadOrders() {
    fetch('/orders')
        .then(response => response.json())
        .then(orders => {
            const tableBody = document.getElementById("ordersTable").getElementsByTagName("tbody")[0];
            tableBody.innerHTML = "";
            orders.forEach(order => {
                const row = tableBody.insertRow();
                ['IdOrder', 'IdCustomer', 'IdRestaurant', 'OrderTime', 'DeliveryTimeForecast', 'IdCourier'].forEach(key => {
                    const cell = row.insertCell();
                    cell.textContent = order[key];
                });
                const actionsCell = row.insertCell();
                actionsCell.innerHTML = `
                    <button onclick="editOrder('${order.IdOrder}')">Редактировать</button>
                    <button onclick="deleteOrder('${order.IdOrder}')">Удалить</button>
                `;
            });
        })
        .catch(error => {
            console.error('Error:', error);
        });
}







// Функция для редактирования заказа
function editOrder(orderId) {
    fetch(`/get_order/${orderId}`)
        .then(response => response.json())
        .then(orderData => {
            // Заполнение формы редактирования данными заказа
            document.getElementById('editOrderId').value = orderId;
            document.getElementById('editIdCustomer').value = orderData.IdCustomer;
            // Заполнение других полей формы

            // Показ модального окна для редактирования
            document.getElementById('editOrderModal').style.display = 'block';
        })
        .catch(error => {
            alert("Ошибка при получении данных заказа: " + error);
        });
}

// Обработчик отправки формы редактирования заказа
document.getElementById('editOrderForm').addEventListener('submit', function(event) {
    event.preventDefault();
    submitEditOrderForm();
});

// Функция отправки обновленных данных заказа на сервер
function submitEditOrderForm() {
    const orderId = document.getElementById('editOrderId').value;
    const updatedOrderData = {
        IdCustomer: document.getElementById('editIdCustomer').value,
        IdRestaurant: document.getElementById('editIdRestaurant').value,
        OrderTime: document.getElementById('editOrderTime').value,
        DeliveryTimeForecast: document.getElementById('editDeliveryTimeForecast').value,
        IdCourier: document.getElementById('editIdCourier').value
    };

    fetch(`/update_order/${orderId}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(updatedOrderData)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Ошибка обновления заказа');
        }
        return response.json();
    })
    .then(data => {
        if (data.message) {
            alert("Заказ успешно обновлен!");
            loadOrders();
            document.getElementById('editOrderModal').style.display = 'none';
        } else if (data.error) {
            alert("Ошибка при обновлении заказа: " + data.error);
        }
    })
    .catch(error => {
        alert("Ошибка: " + error);
    });
}



// Функция для удаления заказа
function deleteOrder(orderId) {
    console.log("Удаляемый orderId:", orderId);
    fetch(`/delete_order/${orderId}`, { method: 'DELETE' })
        .then(response => {
            if (!response.ok) {
                throw new Error('Ошибка удаления заказа');
            }
            return response.json();
        })
        .then(data => {
            alert("Заказ успешно удален!");
            loadOrders();
        })
        .catch(error => {
            alert("Ошибка: " + error);
        });
}

