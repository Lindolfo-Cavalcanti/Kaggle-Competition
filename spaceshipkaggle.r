{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "c7388ba8",
   "metadata": {
    "papermill": {
     "duration": 0.008414,
     "end_time": "2024-07-21T03:00:05.577695",
     "exception": false,
     "start_time": "2024-07-21T03:00:05.569281",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Load libraries and data -----------------------------------------------------"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "388f3572",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:00:05.597726Z",
     "iopub.status.busy": "2024-07-21T03:00:05.595263Z",
     "iopub.status.idle": "2024-07-21T03:00:09.647389Z",
     "shell.execute_reply": "2024-07-21T03:00:09.645598Z"
    },
    "papermill": {
     "duration": 4.064898,
     "end_time": "2024-07-21T03:00:09.650205",
     "exception": false,
     "start_time": "2024-07-21T03:00:05.585307",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching core tidyverse packages\u001b[22m ──────────────────────── tidyverse 2.0.0 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mdplyr    \u001b[39m 1.1.4     \u001b[32m✔\u001b[39m \u001b[34mreadr    \u001b[39m 2.1.5\n",
      "\u001b[32m✔\u001b[39m \u001b[34mforcats  \u001b[39m 1.0.0     \u001b[32m✔\u001b[39m \u001b[34mstringr  \u001b[39m 1.5.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2  \u001b[39m 3.5.1     \u001b[32m✔\u001b[39m \u001b[34mtibble   \u001b[39m 3.2.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mlubridate\u001b[39m 1.9.3     \u001b[32m✔\u001b[39m \u001b[34mtidyr    \u001b[39m 1.3.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mpurrr    \u001b[39m 1.0.2     \n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\u001b[36mℹ\u001b[39m Use the conflicted package (\u001b[3m\u001b[34m<http://conflicted.r-lib.org/>\u001b[39m\u001b[23m) to force all conflicts to become errors\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "randomForest 4.7-1.1\n",
      "\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Type rfNews() to see new features/changes/bug fixes.\n",
      "\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\n",
      "Attaching package: ‘randomForest’\n",
      "\n",
      "\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "The following object is masked from ‘package:dplyr’:\n",
      "\n",
      "    combine\n",
      "\n",
      "\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "The following object is masked from ‘package:ggplot2’:\n",
      "\n",
      "    margin\n",
      "\n",
      "\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Registered S3 methods overwritten by 'dlookr':\n",
      "  method          from  \n",
      "  plot.transform  scales\n",
      "  print.transform scales\n",
      "\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\n",
      "Attaching package: ‘dlookr’\n",
      "\n",
      "\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "The following object is masked from ‘package:tidyr’:\n",
      "\n",
      "    extract\n",
      "\n",
      "\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "The following object is masked from ‘package:base’:\n",
      "\n",
      "    transform\n",
      "\n",
      "\n"
     ]
    }
   ],
   "source": [
    "library(tidyverse)\n",
    "library(randomForest)\n",
    "library(dlookr)\n",
    "library(missRanger)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "c2ba91db",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:00:09.700528Z",
     "iopub.status.busy": "2024-07-21T03:00:09.669936Z",
     "iopub.status.idle": "2024-07-21T03:00:09.803568Z",
     "shell.execute_reply": "2024-07-21T03:00:09.801870Z"
    },
    "papermill": {
     "duration": 0.147249,
     "end_time": "2024-07-21T03:00:09.806520",
     "exception": false,
     "start_time": "2024-07-21T03:00:09.659271",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "train_space = read.csv(\"/kaggle/input/spaceship-titanic/train.csv\")\n",
    "test_space = read.csv(\"/kaggle/input/spaceship-titanic/test.csv\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "fd3081eb",
   "metadata": {
    "papermill": {
     "duration": 0.008763,
     "end_time": "2024-07-21T03:00:09.824199",
     "exception": false,
     "start_time": "2024-07-21T03:00:09.815436",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Create a new dataset with both ------------------------------------------------"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "2471fee2",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:00:09.844650Z",
     "iopub.status.busy": "2024-07-21T03:00:09.843318Z",
     "iopub.status.idle": "2024-07-21T03:00:09.882917Z",
     "shell.execute_reply": "2024-07-21T03:00:09.880975Z"
    },
    "papermill": {
     "duration": 0.052443,
     "end_time": "2024-07-21T03:00:09.885426",
     "exception": false,
     "start_time": "2024-07-21T03:00:09.832983",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t12970 obs. of  15 variables:\n",
      " $ PassengerId : chr  \"0001_01\" \"0002_01\" \"0003_01\" \"0003_02\" ...\n",
      " $ HomePlanet  : chr  \"Europa\" \"Earth\" \"Europa\" \"Europa\" ...\n",
      " $ CryoSleep   : chr  \"False\" \"False\" \"False\" \"False\" ...\n",
      " $ Cabin       : chr  \"B/0/P\" \"F/0/S\" \"A/0/S\" \"A/0/S\" ...\n",
      " $ Destination : chr  \"TRAPPIST-1e\" \"TRAPPIST-1e\" \"TRAPPIST-1e\" \"TRAPPIST-1e\" ...\n",
      " $ Age         : num  39 24 58 33 16 44 26 28 35 14 ...\n",
      " $ VIP         : chr  \"False\" \"False\" \"True\" \"False\" ...\n",
      " $ RoomService : num  0 109 43 0 303 0 42 0 0 0 ...\n",
      " $ FoodCourt   : num  0 9 3576 1283 70 ...\n",
      " $ ShoppingMall: num  0 25 0 371 151 0 3 0 17 0 ...\n",
      " $ Spa         : num  0 549 6715 3329 565 ...\n",
      " $ VRDeck      : num  0 44 49 193 2 0 0 NA 0 0 ...\n",
      " $ Name        : chr  \"Maham Ofracculy\" \"Juanna Vines\" \"Altark Susent\" \"Solam Susent\" ...\n",
      " $ Transported : chr  \"False\" \"True\" \"False\" \"False\" ...\n",
      " $ IsTrain     : logi  TRUE TRUE TRUE TRUE TRUE TRUE ...\n"
     ]
    }
   ],
   "source": [
    "test_space$Transported = NA\n",
    "train_space$IsTrain = TRUE\n",
    "test_space$IsTrain = FALSE\n",
    "full_space = rbind(train_space, test_space)\n",
    "\n",
    "str(full_space)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "5df050f0",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:00:09.905590Z",
     "iopub.status.busy": "2024-07-21T03:00:09.904327Z",
     "iopub.status.idle": "2024-07-21T03:00:10.476985Z",
     "shell.execute_reply": "2024-07-21T03:00:10.474139Z"
    },
    "papermill": {
     "duration": 0.586352,
     "end_time": "2024-07-21T03:00:10.480570",
     "exception": false,
     "start_time": "2024-07-21T03:00:09.894218",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nOzdeVxN+f8H8M+9bdpLy61UJlrtqUiWLElki7Qpky1ZhhkGxW+yx4SMUWQng8i+\nDkaTfUs7yfIthdRtIe3dur8/zjhStxS37u14PR895nHO537uue9P5xgvn7NcFp/PJwAAAADQ\n+rFFXQAAAAAACAeCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAA\nMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABD\nINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASC\nHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgB\nAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAA\nAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAA\nMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABD\nINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASC\nHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgB\nAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAA\nAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAA\nMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABD\nINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASC\nHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgBAAAAMASCHQAAAABDINgB\n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\nvqiOx+PduXuvr41NI/skJScPHmq/4JdfwraG1jwVCC3JwsKCxWLRM9w8Hu/OnTt9+zb2EBWh\n7p2sWIRFX1RXVcWLTbpj2b125akvkjxmDZ4+ccEavzD6/GZ+Afd2TFTNf0CyWCw2Wyxme7qZ\nWbEIK+7Rp3HFJd+x7CZgXBN/GjzNfcHqRZ/Gden6yddvX3YfqtzRhtXRhpX85OG6kIW/b13c\nogNoNAkJIinsHwmx2IfQKAh2rZuOjo6ZmdnOnTvT0tJu37598+ZNe3v7Btr19PS0tbX379//\n4sWLY8eO0QlvwoQJ//7775kzZ9LS0s6dOxcfH0+d8K1vO1JSUvr6+pcuXXrx4sWuXbvqK09B\nQSEzMzOtGZ61oaGm6TzGI2DNwv9n7z7jmrr6OICfmzDKJsgWEBAREGSjoogLN9gqDhAUByrq\nU60tCFitE62jrbPWjRYciLh3qdSFAqKCW8Q6EAlhyQwZz4toVEREmxBy+X0/eZHce3L5Hy6B\nH+fc8TDnXlExZ8GySAaDMcwvgBAybVZIr0FuDbyXx+NNmRk8JiA0bMJMiRcmEfr6+oEBo8Jn\nR967f5/D4URGz2EwqICRIwkhIRMmuHXq3EAbHo8XPDYkdMKEmd9+K+t+tGh6enqBgYHh4eH3\n7t3jcDiRkZEMBiMgIEDWdX1aK5a+X7/AmLXhj/69V1zK+Xl9JINi+PUNIIT8sDDEb6wbIYTP\n5333U/Cor0PHj3rvQ1RY9HLMt/3WbF1YXMqprCr/M/H3rDvp3Tz6yKYn72vF0vfrG7hsXfij\nJ/dKSjnLN0QyKIavTwAhJHxxyJDxr/v1/YLgUX6h40a+1681C/fkXBKKH/Y2rpHTV8ye+rNs\nevIpCgpSeCDYyQ+Mrsq9iIiIjRs3RkVFaWpqTpo0SXzVknqXMxiMiIiItWvXzpkzx8vLq02b\nNqLGrq6u06dP37t3786dO42NjcPDwzt06NDw9idPnrxmzZq5c+f26tVLQaH+HyQfH5+LFy+u\nXr36t99+k3jHf/t507pNq6IWzKysrLBtb3888bxoRtWktZl4ijZgnG9e/jNCiEMHp+FjBhBC\nBvb9ur+PL0VRf6Wc/Cvl7bX6ZoTNHuo3SuJFfrFNv/++6tdfZ876vqKiwr5Dh/PnzolmVM1M\nzcSze/W2uZaZSVHUyVOnTp56e2HV4f7DoiMjZdOTFmzTpk2rVq2aOXNmRUWFvb39+fPn5WVa\n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\n5tTTqXrbGBkaE0Kmhc1oa2mlrqYePDrEq6v3UXk4MZbFYpWV1d1NdQaMoSkZGBh8co80po18\nqbdHzWEg/0sIBBixa8kQ7GTp2bNn0dHR4rlLLS0tQkhtbf2HMojG0p4+fSp6+eLFC/Ho2rvy\n8/NZLFZjFtahq6tLCPnYRKqysrKrq2tcXFx5ebmz89vD0dhsdn5+vr+/f6tWrRrevmS5ublT\nFCU+qI7H4125ctmzS9fGtGEXsv8+lyx85wKeFEUxmcwmK/5jjI1bUxQlPqiOx+NduXq5S+f3\nO+XiXm8bAwPD1sYmBQUvxS0FQoH4eM3mrH379hRFiQ+q4/F4ly9f7tq1a8PvAulxd3Ovu0dS\nL3u+v0ca00a+uLt/0KPLl9u2bSvbqr4QTp5o2RDsZMnW1tbMzOyXX37Jzs6+ffv2rl272rVr\np62tXW9jY2NjW1vbzZs35+bmXrp06cKFC3379hWvPXLkSG5ubnJycnZ2tqurawMLP8bU1NTI\nyGjHjh05OTn79+//8AJUnp6eGRkZbm5u78YFDQ0NBQWF8+fP3717d9OmTYSQprnHs76e/qiR\ngZFR4ffv3+MUceb8GEkxGCNHBBBCJoSGdPZ0a6BNwcuXg3z7LY5ZyCnilJeX/7Hp94xr6V27\ndmuCshumpqo2cnhg1Nzw+w/uFRVxfpwfyWAwRvgHEEJCw0I8vd0IIXp6+vW2oShqxvRZCxbP\nTc+4Wl5Rvitux6XLF4Z9M0LWffo0bW3twMDA8PDwe/fucTicyMhIBoMREBAg67paLn19/cCA\nwIjZr/dIVFQkg8EIGBVACBk3LsTdw63hNnJKX18/MDAwIuK9Hrm5ucm6ri8ijcudINjJD9lf\njawlYzKZCxcu3LZt2+LFiymK6tix48SJExtoHxERsXHjxqioKE1NzUmTJr07cqarq7t48eLq\n6mp/f38XFxfRsF+dhQ0Xw2AwwsPD165dO2fOHE9PT11d3Tqzt+7u7goKCnUug6eiojJ9+vSd\nO3eeOnXK39//2rVreXl55ubmn/ut+AJ//L4l6WBiXPyu6urqNm3MUy+la2hoEEJ69extY2Pb\nQJsOHeyvpd08debk0qWLCSH6Bgapl9IdOzo1Qc2f9PvaLQcPJ8bv2VVdU93GzPzSuXQNdQ1C\nSE/v3jbtbRtuM33qzHbt2h85dmhvQryenv6Fv686OX5ipzcTW7ZsSUxM3LVrV3V1tbm5eXr6\n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\n2draenh4rFq1SnxtLU1NzSdPnsi2wi9WWlp64sSJDRs2iF7OmDHDwMBg4cKFNTU1s2fPVlBQ\nWLp0qXzdWbVHjx6EkL59+2ZnZ2/fvl00asXhcETxlMvlqqurq6mpycUV7CorK2NjYyMjI8eN\nG/ftt99u2bJFFHratGkTHh5+8uTJ48ePi1o6OztXVFQUFRXJtN4vUVlZmZ2dLfo0eXl57d+/\nX3wvu6qqqg0bNty9e9fExGT9+vXdunWTaaUAXwgjdiBnlJSUnj59yuVyr1+/npqaamNjI5q8\nU1FRad269datW1VVVUV/jQ4fPmxsbHz48OGuXbtqamrKuvDGunv3bnR09NixY0W3ojIyMho6\ndOhff/2VkpIiOuJn586dtra2zX/sp14aGhrW1tbbt29XUlKytbVlMpnu7u5Hjx69c+dO7969\nXV1dDQwMmvMwycOHD2NiYrS0tExMTERLFBUVi4uLc3JygoODt2zZ0qpVq7Zt2zKZzF27dlVU\nVCQmJlpZWf34449ycc5yXl7esWPHgoODRUcsvPvvkLGxsYqKytatW9u2baupqblz504Gg+Hv\n7y9fA3U3btyYPXv22bNnDx8+rK+vP2DAgJSUlNTUVC8vL0VFRYqijh492r17dz09PXkZ3Qf4\nEIIdyB9tbe1jx46Jrum/adMmoVBoY2PDYDBMTU01NTW3bNly8+bNkydPFhcXL168ODU1tbS0\n1NXVVdZVN5aWltaxY8fU1NT69OkjOgrN3d3d19c3NTU1Njb24MGDbdq0CQsLk6/jmfLz82/f\nvq2kpKSmpmZgYKCjo7N58+a2bdu2bt1aRUUlPz8/JSWFEOLp6dnMbyZ2/Pjxf/755/z580+e\nPOnQoYPoz7+BgcG2bduCg4NVVVV37txpZ2fn5uamo6Nz9epVKyur8ePHy8sJsGpqasnJyTk5\nOVZWVvn5+adPn46Njd23b9/Dhw8dHBw6duzI4XC2bdt28eJFQ0PDmTNnysURq2JVVVXh4eEh\nISGRkZE8Hm/r1q12dnaDBw8+fPjw+fPnCSG7du1SVVUdOXJkMz8IEqBhCHYgf/T09C5cuMBg\nMCZOnNimTZu4uLhz585ZWlrq6upaW1s7OjoWFBQYGxtPnz5dQ0MjKyvrq6++av7B7tWrV5mZ\nmSYmJkwmk6KoY8eODRo0yMHBQXQUmo+Pz9dff925c2dfX19fX1/5SnX79u1btmxZWlpaUlJS\n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\nDw8P7sBCSIQdbNiIESOcnJwiIiJsaJrk0qVLs2bN8vT0tBw2dfTo0czMTH9//5UrVzo7O1se\nELQVBw8enDt3bnR09LBhw86cObNz586UlJTr79BduHBh8eLF48aN8/b2zszMjImJycrKmjx5\nsm1VnSRJcrl869atoaGhnp6ekiSNGzfuyJEjpaWlSUlJCQkJgYGBGo3G2mMciDo7Oz/44INP\nPvnkiSeeuPfee2tra3fs2JGenh4eHn727Nn169cbDAZLmCqVyurqastTd9YeNXBnEXawYXK5\nPCgoqD9XXVdXV2Njo9ls7ltjuHv37lOnTr300kujRo2qr68/ceJEfHx8YGCgo6PjqlWrgoOD\nLelgEzw9PRsaGrZs2ZKYmBgaGlpaWtrY2JiQkND3N9Lb25ufny+Xy8PCwuRyuaur69ChQ607\n5v/eoUOH5s2bt23bNstt1paWlm3btlk225PL5e3t7Xv37v36669TUlJs68lOYfT29i5atOir\nr756++23w8LC3N3d9Xr9+vXrNRqNr69vVFRUXV1deXm55fThK1euWGb3+/O5JsBtwUQ0cKcc\nPXr08ccfnzNnztNPP71kyZKOjg5JkmQyWUdHx48//jh//vxLly699dZbluWu99xzT0pKyqZN\nm6w96lsgl8tffPFFZ2fnV155RaVSzZ49+9ChQ6tXr+67QKVS6XS6M2fOWHGQ/72+03h7e3vb\n29vfeeedu+++W6fTvfLKK4cOHbLsdz1v3rxvv/32xIkTpaWlzzzzTHNzc3FxsXWHPTC1tLSc\nPHkyOTm5vb39yJEjlhddXV2VSmVnZ6ckSfb29nPnzpXJZK+++uqlS5dee+01Dw+P2NhYq44a\n+D0wYwfcEW1tbbNnz87MzFy8eHFUVJTJZBo3bpzloaWCgoKSkpLQ0NC//OUvjo6OV69eXbJk\nyfjx4/V6fUJCgr29vbXHfgtqamouXLhQW1v73XffTZ06Va1Wr1u3rru7Ozw8XCaTtbW1rV27\nNjk5OSAgwNojvYnq6uoXX3wxMzNToVDk5uYuX748KCjoySef1Ov1HR0da9eujY+PnzRpUm1t\nbW5ubllZmdFonDZtmslk+vbbbydMmGDt4Q84CxcubG1tfeihh65cuZKXlzdmzBgPD4/8/Py6\nujq1Wh0cHKxQKJRKpU6n27hxY1FRkUKhWLRoESfAYiAg7IA7Yt++fV9++eWCBQvkcrmbm5ul\n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\nXe7k5GTFAQPAb0TYAbdGoVBUVlaazWbLjhhyuTwgICA3N3fChAlDhgwZOXJkbGysrVSdJEmW\ndbvbt28/dOhQU1NTYWHh3Llzo6KiJEny9PSMiYk5fvz4V199FR4ePnPmTJvbseXnNlUeNmyY\nTqf75ptvKisrk5KSWFMJQBiEHXBz586d279//4ULF4YPHy6TydRqdU5Ojq+vr6+vryRJSqVy\n48aNGRkZtnJG6k/0LSloaGh48803rz8Yw8XFJS4uLi0tLTIyst+uArly5crixYuHDx/u4eEh\nSdJ3331XVVXl7Ow8ePDgX9hU2TLbWlFRUV1dnZycbHMLQQDghgg74CaqqqoWLFjQ1NRUWlr6\nxRdfGAyGoKCga9eurVq1ys7Ozs7ObvXq1YMGDXrwwQetPdJfz9nZ2d/fv7Ky0t3dPTQ01NrD\nuTX29vZ1dXUFBQXx8fFnz5594YUXjhw5UlJSEhQUlJiY+AubKisUiqioqBMnTkRFRfXbbAWA\nWyLr7e219hiA/stsNj/66KMzZsyYOHHimTNnlixZIpfLX3/99UGDBhUXF2/YsKGtrS0qKuqZ\nZ56x3bPC+pSUlKxYsWLu3LmxsbHWHsut6ezsnD9//uXLl/39/UNCQtLT07Ozs7dv3/766687\nOTnNnz+/o6PDaDR+/fXXQ4YMeeWVV5ifAyAqwg74t8rKyvz8fJPJlJCQ8NRTTymVymPHjr3w\nwgvr1q2z3GY1mUx/+tOf4uLiZsyYYXlLT0+PDT1Rd1P//Oc/KyoqXnvttf6/38eBAwcqKip6\nenomTJgQHx9/4cKFWbNm/fDDD++//75Go+nt7f373//e0NDw1ltvKZXK0tLS5ubmgICAzMxM\nm3tSEAD+e9yKBSRJkrq7u5cvX7558+asrKzo6OjS0tLGxsbExESFQlFUVDRixAjLkQwqlcrF\nxWX9+vVTp0619JxtrRK9KZ1O99VXX7W0tPTzSbuioqLly5frdDqZTJaXlxcZGent7R0ZGblr\n167Ozk69Xi+TyQwGw+eff15VVZWamhoeHm6jmyoDwC0h7ID/3ae3vr5+6dKlBoMhMDDQ398/\nLy/PaDR6eHhcvnx506ZNluPCJElycHDYunVrVlaWkBM/crl8/PjxsbGx/TlYr169unDhwvnz\n50+aNCkmJiYlJcWyisXFxcXPzy87O9tyYq+9vb1er9+yZcvJkyeNRqO1Rw0AvwdxbiEBv5pC\n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\nEHYAAACCIOwAAAAEQdgBAAAIgrADAAAQBGEHAAAgCMIOAABAEIQdAACAIAg7AAAAQRB2AAAA\ngiDsAAAABEHYAQAACIKwAwAAEARhBwAAIAjCDgAAQBCEHQAAgCAIOwAAAEEQdgAAAIIg7AAA\nAARB2AEAAAiCsAMAABAEYQcAACAIwg4AAEAQhB0AAIAgCDsAAABBEHYAAACCIOwAAAAEQdgB\nAAAIgrADAAAQBGEHAAAgCMIOAABAEIQdAACAIAg7AAAAQRB2AAAAgiDsAAAABEHYAQAACIKw\nAwAAEARhBwAAIAjCDgAAQBCEHQAAgCAIOwAAAEEQdgAAAIIg7AAAAARB2AEAAAiCsAMAABAE\nYQcAACAIwg4AAEAQhB0AAIAgCDsAAABBEHYAAACCIOwAAAAEQdgBAAAIgrADAAAQBGEHAAAg\nCMIOAABAEIQdAACAIAg7AAAAQRB2AAAAgiDsAAAABEHYAQAACIKwAwAAEARhBwAAIAjCDgAA\nQBCEHQAAgCAIOwAAAEEQdgAAAIIg7AAAAARB2AEAAAiCsAMAABAEYQcAACAIwg4AAEAQhB0A\nAIAgCDsAAABBEHYAAACCIOwAAAAEQdgBAAAIgrADAAAQBGEHAAAgCMIOAABAEIQdAACAIAg7\nAAAAQRB2AAAAgiDsAAAABEHYAQAACIKwAwAAEARhBwAAIAjCDgAAQBCEHQAAgCAIOwAAAEEQ\ndgAAAIIg7AAAAARB2AEAAAiCsAMAABAEYQcAACAIwg4AAEAQ/wN8IL/NKKX/9gAAAABJRU5E\nrkJggg=="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "full_space %>% correlate() %>% plot()"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "adbbe006",
   "metadata": {
    "papermill": {
     "duration": 0.009668,
     "end_time": "2024-07-21T03:00:10.501884",
     "exception": false,
     "start_time": "2024-07-21T03:00:10.492216",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Clean data ------------------------------------------------------------------\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "be8f7898",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:00:10.524613Z",
     "iopub.status.busy": "2024-07-21T03:00:10.523250Z",
     "iopub.status.idle": "2024-07-21T03:00:48.156092Z",
     "shell.execute_reply": "2024-07-21T03:00:48.154601Z"
    },
    "papermill": {
     "duration": 37.652905,
     "end_time": "2024-07-21T03:00:48.164859",
     "exception": false,
     "start_time": "2024-07-21T03:00:10.511954",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      " iter imp variable\n",
      "  1   1  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  1   2  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  1   3  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  1   4  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  1   5  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  2   1  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  2   2  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  2   3  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  2   4  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  2   5  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  3   1  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  3   2  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  3   3  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  3   4  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  3   5  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  4   1  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  4   2  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  4   3  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  4   4  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  4   5  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  5   1  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  5   2  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  5   3  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  5   4  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n",
      "  5   5  Age  RoomService  FoodCourt  ShoppingMall  VRDeck\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message:\n",
      "“Number of logged events: 8”\n"
     ]
    }
   ],
   "source": [
    "full_space$Age = imputate_na(full_space, Age, Spa, method = \"mice\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "09b78bca",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:00:48.188376Z",
     "iopub.status.busy": "2024-07-21T03:00:48.186583Z",
     "iopub.status.idle": "2024-07-21T03:00:48.203799Z",
     "shell.execute_reply": "2024-07-21T03:00:48.202346Z"
    },
    "papermill": {
     "duration": 0.030642,
     "end_time": "2024-07-21T03:00:48.205780",
     "exception": false,
     "start_time": "2024-07-21T03:00:48.175138",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "full_space$Age %>% is.na() %>% sum()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "01b8b2b9",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:00:48.228907Z",
     "iopub.status.busy": "2024-07-21T03:00:48.227599Z",
     "iopub.status.idle": "2024-07-21T03:00:48.255522Z",
     "shell.execute_reply": "2024-07-21T03:00:48.253765Z"
    },
    "papermill": {
     "duration": 0.041484,
     "end_time": "2024-07-21T03:00:48.257484",
     "exception": false,
     "start_time": "2024-07-21T03:00:48.216000",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t12970 obs. of  13 variables:\n",
      " $ PassengerId : chr  \"0001_01\" \"0002_01\" \"0003_01\" \"0003_02\" ...\n",
      " $ HomePlanet  : chr  \"Europa\" \"Earth\" \"Europa\" \"Europa\" ...\n",
      " $ CryoSleep   : chr  \"False\" \"False\" \"False\" \"False\" ...\n",
      " $ Cabin       : chr  \"B/0/P\" \"F/0/S\" \"A/0/S\" \"A/0/S\" ...\n",
      " $ Destination : chr  \"TRAPPIST-1e\" \"TRAPPIST-1e\" \"TRAPPIST-1e\" \"TRAPPIST-1e\" ...\n",
      " $ Age         : 'imputation' num  39 24 58 33 16 44 26 28 35 14 ...\n",
      "  ..- attr(*, \"var_type\")= chr \"numerical\"\n",
      "  ..- attr(*, \"method\")= chr \"mice\"\n",
      "  ..- attr(*, \"na_pos\")= int [1:270] 51 65 138 182 185 250 283 326 382 435 ...\n",
      "  ..- attr(*, \"seed\")= int 80095\n",
      "  ..- attr(*, \"type\")= chr \"missing values\"\n",
      "  ..- attr(*, \"message\")= chr \"complete imputation\"\n",
      "  ..- attr(*, \"success\")= logi TRUE\n",
      " $ VIP         : chr  \"False\" \"False\" \"True\" \"False\" ...\n",
      " $ RoomService : num  0 109 43 0 303 0 42 0 0 0 ...\n",
      " $ FoodCourt   : num  0 9 3576 1283 70 ...\n",
      " $ ShoppingMall: num  0 25 0 371 151 0 3 0 17 0 ...\n",
      " $ Spa         : num  0 549 6715 3329 565 ...\n",
      " $ VRDeck      : num  0 44 49 193 2 0 0 NA 0 0 ...\n",
      " $ Name        : chr  \"Maham Ofracculy\" \"Juanna Vines\" \"Altark Susent\" \"Solam Susent\" ...\n"
     ]
    }
   ],
   "source": [
    "full_space_imputet = full_space\n",
    "\n",
    "full_space_imputet$Transported = NULL\n",
    "\n",
    "full_space_imputet$IsTrain = NULL\n",
    "\n",
    "str(full_space_imputet)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "3f939d83",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:00:48.281219Z",
     "iopub.status.busy": "2024-07-21T03:00:48.279753Z",
     "iopub.status.idle": "2024-07-21T03:02:30.674617Z",
     "shell.execute_reply": "2024-07-21T03:02:30.672321Z"
    },
    "papermill": {
     "duration": 102.422808,
     "end_time": "2024-07-21T03:02:30.690613",
     "exception": false,
     "start_time": "2024-07-21T03:00:48.267805",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      "Missing value imputation by random forests\n",
      "\n",
      "  Variables to impute:\t\tRoomService, FoodCourt, ShoppingMall, Spa, VRDeck\n",
      "  Variables used to impute:\tPassengerId, HomePlanet, CryoSleep, Cabin, Destination, Age, VIP, RoomService, FoodCourt, ShoppingMall, Spa, VRDeck, Name\n",
      "\n",
      "iter 1\n",
      "\r",
      "  |                                                                            \r",
      "  |                                                                      |   0%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\r",
      "  |                                                                            \r",
      "  |==============                                                        |  20%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\r",
      "  |                                                                            \r",
      "  |============================                                          |  40%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\r",
      "  |                                                                            \r",
      "  |==========================================                            |  60%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\r",
      "  |                                                                            \r",
      "  |========================================================              |  80%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\r",
      "  |                                                                            \r",
      "  |======================================================================| 100%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      "iter 2\n",
      "\r",
      "  |                                                                            \r",
      "  |                                                                      |   0%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\r",
      "  |                                                                            \r",
      "  |==============                                                        |  20%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\r",
      "  |                                                                            \r",
      "  |============================                                          |  40%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\r",
      "  |                                                                            \r",
      "  |==========================================                            |  60%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\r",
      "  |                                                                            \r",
      "  |========================================================              |  80%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\r",
      "  |                                                                            \r",
      "  |======================================================================| 100%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      "iter 3\n",
      "\r",
      "  |                                                                            \r",
      "  |                                                                      |   0%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\r",
      "  |                                                                            \r",
      "  |==============                                                        |  20%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\r",
      "  |                                                                            \r",
      "  |============================                                          |  40%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\r",
      "  |                                                                            \r",
      "  |==========================================                            |  60%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\r",
      "  |                                                                            \r",
      "  |========================================================              |  80%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\r",
      "  |                                                                            \r",
      "  |======================================================================| 100%"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n"
     ]
    }
   ],
   "source": [
    "full_space_imputet = missRanger(\n",
    "    full_space_imputet, \n",
    "    formula = . ~ .,\n",
    "    num.trees = 1000)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "560b3b0e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:02:30.717031Z",
     "iopub.status.busy": "2024-07-21T03:02:30.715759Z",
     "iopub.status.idle": "2024-07-21T03:02:30.739423Z",
     "shell.execute_reply": "2024-07-21T03:02:30.737507Z"
    },
    "papermill": {
     "duration": 0.03919,
     "end_time": "2024-07-21T03:02:30.741445",
     "exception": false,
     "start_time": "2024-07-21T03:02:30.702255",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t12970 obs. of  13 variables:\n",
      " $ PassengerId : chr  \"0001_01\" \"0002_01\" \"0003_01\" \"0003_02\" ...\n",
      " $ HomePlanet  : chr  \"Europa\" \"Earth\" \"Europa\" \"Europa\" ...\n",
      " $ CryoSleep   : chr  \"False\" \"False\" \"False\" \"False\" ...\n",
      " $ Cabin       : chr  \"B/0/P\" \"F/0/S\" \"A/0/S\" \"A/0/S\" ...\n",
      " $ Destination : chr  \"TRAPPIST-1e\" \"TRAPPIST-1e\" \"TRAPPIST-1e\" \"TRAPPIST-1e\" ...\n",
      " $ Age         : 'imputation' num  39 24 58 33 16 44 26 28 35 14 ...\n",
      "  ..- attr(*, \"var_type\")= chr \"numerical\"\n",
      "  ..- attr(*, \"method\")= chr \"mice\"\n",
      "  ..- attr(*, \"na_pos\")= int [1:270] 51 65 138 182 185 250 283 326 382 435 ...\n",
      "  ..- attr(*, \"seed\")= int 80095\n",
      "  ..- attr(*, \"type\")= chr \"missing values\"\n",
      "  ..- attr(*, \"message\")= chr \"complete imputation\"\n",
      "  ..- attr(*, \"success\")= logi TRUE\n",
      " $ VIP         : chr  \"False\" \"False\" \"True\" \"False\" ...\n",
      " $ RoomService : num  0 109 43 0 303 0 42 0 0 0 ...\n",
      " $ FoodCourt   : num  0 9 3576 1283 70 ...\n",
      " $ ShoppingMall: num  0 25 0 371 151 0 3 0 17 0 ...\n",
      " $ Spa         : num  0 549 6715 3329 565 ...\n",
      " $ VRDeck      : num  0 44 49 193 2 ...\n",
      " $ Name        : chr  \"Maham Ofracculy\" \"Juanna Vines\" \"Altark Susent\" \"Solam Susent\" ...\n"
     ]
    }
   ],
   "source": [
    "str(full_space_imputet)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "57fcef22",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:02:30.767918Z",
     "iopub.status.busy": "2024-07-21T03:02:30.766653Z",
     "iopub.status.idle": "2024-07-21T03:02:30.781637Z",
     "shell.execute_reply": "2024-07-21T03:02:30.780160Z"
    },
    "papermill": {
     "duration": 0.030264,
     "end_time": "2024-07-21T03:02:30.783638",
     "exception": false,
     "start_time": "2024-07-21T03:02:30.753374",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>PassengerId</dt><dd>0</dd><dt>HomePlanet</dt><dd>0</dd><dt>CryoSleep</dt><dd>0</dd><dt>Cabin</dt><dd>0</dd><dt>Destination</dt><dd>0</dd><dt>Age</dt><dd>0</dd><dt>VIP</dt><dd>0</dd><dt>RoomService</dt><dd>0</dd><dt>FoodCourt</dt><dd>0</dd><dt>ShoppingMall</dt><dd>0</dd><dt>Spa</dt><dd>0</dd><dt>VRDeck</dt><dd>0</dd><dt>Name</dt><dd>0</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[PassengerId] 0\n",
       "\\item[HomePlanet] 0\n",
       "\\item[CryoSleep] 0\n",
       "\\item[Cabin] 0\n",
       "\\item[Destination] 0\n",
       "\\item[Age] 0\n",
       "\\item[VIP] 0\n",
       "\\item[RoomService] 0\n",
       "\\item[FoodCourt] 0\n",
       "\\item[ShoppingMall] 0\n",
       "\\item[Spa] 0\n",
       "\\item[VRDeck] 0\n",
       "\\item[Name] 0\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "PassengerId\n",
       ":   0HomePlanet\n",
       ":   0CryoSleep\n",
       ":   0Cabin\n",
       ":   0Destination\n",
       ":   0Age\n",
       ":   0VIP\n",
       ":   0RoomService\n",
       ":   0FoodCourt\n",
       ":   0ShoppingMall\n",
       ":   0Spa\n",
       ":   0VRDeck\n",
       ":   0Name\n",
       ":   0\n",
       "\n"
      ],
      "text/plain": [
       " PassengerId   HomePlanet    CryoSleep        Cabin  Destination          Age \n",
       "           0            0            0            0            0            0 \n",
       "         VIP  RoomService    FoodCourt ShoppingMall          Spa       VRDeck \n",
       "           0            0            0            0            0            0 \n",
       "        Name \n",
       "           0 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "full_space_imputet %>% is.na() %>% colSums()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "bbeeebdd",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:02:30.810887Z",
     "iopub.status.busy": "2024-07-21T03:02:30.809655Z",
     "iopub.status.idle": "2024-07-21T03:02:30.826436Z",
     "shell.execute_reply": "2024-07-21T03:02:30.825038Z"
    },
    "papermill": {
     "duration": 0.032803,
     "end_time": "2024-07-21T03:02:30.828594",
     "exception": false,
     "start_time": "2024-07-21T03:02:30.795791",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "full_space$RoomService = full_space_imputet$RoomService\n",
    "full_space$FoodCourt = full_space_imputet$FoodCourt\n",
    "full_space$ShoppingMall = full_space_imputet$ShoppingMall\n",
    "full_space$Spa = full_space_imputet$Spa\n",
    "full_space$VRDeck = full_space_imputet$VRDeck"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "e7c0aa7d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:02:30.855387Z",
     "iopub.status.busy": "2024-07-21T03:02:30.854148Z",
     "iopub.status.idle": "2024-07-21T03:02:30.868424Z",
     "shell.execute_reply": "2024-07-21T03:02:30.866964Z"
    },
    "papermill": {
     "duration": 0.029928,
     "end_time": "2024-07-21T03:02:30.870562",
     "exception": false,
     "start_time": "2024-07-21T03:02:30.840634",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>PassengerId</dt><dd>0</dd><dt>HomePlanet</dt><dd>0</dd><dt>CryoSleep</dt><dd>0</dd><dt>Cabin</dt><dd>0</dd><dt>Destination</dt><dd>0</dd><dt>Age</dt><dd>0</dd><dt>VIP</dt><dd>0</dd><dt>RoomService</dt><dd>0</dd><dt>FoodCourt</dt><dd>0</dd><dt>ShoppingMall</dt><dd>0</dd><dt>Spa</dt><dd>0</dd><dt>VRDeck</dt><dd>0</dd><dt>Name</dt><dd>0</dd><dt>Transported</dt><dd>4277</dd><dt>IsTrain</dt><dd>0</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[PassengerId] 0\n",
       "\\item[HomePlanet] 0\n",
       "\\item[CryoSleep] 0\n",
       "\\item[Cabin] 0\n",
       "\\item[Destination] 0\n",
       "\\item[Age] 0\n",
       "\\item[VIP] 0\n",
       "\\item[RoomService] 0\n",
       "\\item[FoodCourt] 0\n",
       "\\item[ShoppingMall] 0\n",
       "\\item[Spa] 0\n",
       "\\item[VRDeck] 0\n",
       "\\item[Name] 0\n",
       "\\item[Transported] 4277\n",
       "\\item[IsTrain] 0\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "PassengerId\n",
       ":   0HomePlanet\n",
       ":   0CryoSleep\n",
       ":   0Cabin\n",
       ":   0Destination\n",
       ":   0Age\n",
       ":   0VIP\n",
       ":   0RoomService\n",
       ":   0FoodCourt\n",
       ":   0ShoppingMall\n",
       ":   0Spa\n",
       ":   0VRDeck\n",
       ":   0Name\n",
       ":   0Transported\n",
       ":   4277IsTrain\n",
       ":   0\n",
       "\n"
      ],
      "text/plain": [
       " PassengerId   HomePlanet    CryoSleep        Cabin  Destination          Age \n",
       "           0            0            0            0            0            0 \n",
       "         VIP  RoomService    FoodCourt ShoppingMall          Spa       VRDeck \n",
       "           0            0            0            0            0            0 \n",
       "        Name  Transported      IsTrain \n",
       "           0         4277            0 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "full_space %>% is.na() %>% colSums()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "d8fec116",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:02:30.897861Z",
     "iopub.status.busy": "2024-07-21T03:02:30.896641Z",
     "iopub.status.idle": "2024-07-21T03:02:30.921090Z",
     "shell.execute_reply": "2024-07-21T03:02:30.919004Z"
    },
    "papermill": {
     "duration": 0.040709,
     "end_time": "2024-07-21T03:02:30.923355",
     "exception": false,
     "start_time": "2024-07-21T03:02:30.882646",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t12970 obs. of  15 variables:\n",
      " $ PassengerId : chr  \"0001_01\" \"0002_01\" \"0003_01\" \"0003_02\" ...\n",
      " $ HomePlanet  : chr  \"Europa\" \"Earth\" \"Europa\" \"Europa\" ...\n",
      " $ CryoSleep   : chr  \"False\" \"False\" \"False\" \"False\" ...\n",
      " $ Cabin       : chr  \"B/0/P\" \"F/0/S\" \"A/0/S\" \"A/0/S\" ...\n",
      " $ Destination : chr  \"TRAPPIST-1e\" \"TRAPPIST-1e\" \"TRAPPIST-1e\" \"TRAPPIST-1e\" ...\n",
      " $ Age         : 'imputation' num  39 24 58 33 16 44 26 28 35 14 ...\n",
      "  ..- attr(*, \"var_type\")= chr \"numerical\"\n",
      "  ..- attr(*, \"method\")= chr \"mice\"\n",
      "  ..- attr(*, \"na_pos\")= int [1:270] 51 65 138 182 185 250 283 326 382 435 ...\n",
      "  ..- attr(*, \"seed\")= int 80095\n",
      "  ..- attr(*, \"type\")= chr \"missing values\"\n",
      "  ..- attr(*, \"message\")= chr \"complete imputation\"\n",
      "  ..- attr(*, \"success\")= logi TRUE\n",
      " $ VIP         : chr  \"False\" \"False\" \"True\" \"False\" ...\n",
      " $ RoomService : num  0 109 43 0 303 0 42 0 0 0 ...\n",
      " $ FoodCourt   : num  0 9 3576 1283 70 ...\n",
      " $ ShoppingMall: num  0 25 0 371 151 0 3 0 17 0 ...\n",
      " $ Spa         : num  0 549 6715 3329 565 ...\n",
      " $ VRDeck      : num  0 44 49 193 2 ...\n",
      " $ Name        : chr  \"Maham Ofracculy\" \"Juanna Vines\" \"Altark Susent\" \"Solam Susent\" ...\n",
      " $ Transported : chr  \"False\" \"True\" \"False\" \"False\" ...\n",
      " $ IsTrain     : logi  TRUE TRUE TRUE TRUE TRUE TRUE ...\n"
     ]
    }
   ],
   "source": [
    "str(full_space)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ba8ed7dc",
   "metadata": {
    "papermill": {
     "duration": 0.013314,
     "end_time": "2024-07-21T03:02:30.950415",
     "exception": false,
     "start_time": "2024-07-21T03:02:30.937101",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Converting to factor ----------------------------------------------------------\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "a34dcc4d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:02:30.978365Z",
     "iopub.status.busy": "2024-07-21T03:02:30.977056Z",
     "iopub.status.idle": "2024-07-21T03:02:31.120922Z",
     "shell.execute_reply": "2024-07-21T03:02:31.119305Z"
    },
    "papermill": {
     "duration": 0.160334,
     "end_time": "2024-07-21T03:02:31.123058",
     "exception": false,
     "start_time": "2024-07-21T03:02:30.962724",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t12970 obs. of  15 variables:\n",
      " $ PassengerId : Factor w/ 12970 levels \"0001_01\",\"0002_01\",..: 1 2 3 4 5 6 7 8 9 10 ...\n",
      " $ HomePlanet  : Factor w/ 4 levels \"\",\"Earth\",\"Europa\",..: 3 2 3 3 2 2 2 2 2 3 ...\n",
      " $ CryoSleep   : Factor w/ 3 levels \"\",\"False\",\"True\": 2 2 2 2 2 2 2 3 2 3 ...\n",
      " $ Cabin       : Factor w/ 9826 levels \"\",\"A/0/P\",\"A/0/S\",..: 210 3243 3 3 3245 3242 5131 6877 5348 212 ...\n",
      " $ Destination : Factor w/ 4 levels \"\",\"55 Cancri e\",..: 4 4 4 4 4 3 4 4 4 2 ...\n",
      " $ Age         : 'imputation' num  39 24 58 33 16 44 26 28 35 14 ...\n",
      "  ..- attr(*, \"var_type\")= chr \"numerical\"\n",
      "  ..- attr(*, \"method\")= chr \"mice\"\n",
      "  ..- attr(*, \"na_pos\")= int [1:270] 51 65 138 182 185 250 283 326 382 435 ...\n",
      "  ..- attr(*, \"seed\")= int 80095\n",
      "  ..- attr(*, \"type\")= chr \"missing values\"\n",
      "  ..- attr(*, \"message\")= chr \"complete imputation\"\n",
      "  ..- attr(*, \"success\")= logi TRUE\n",
      " $ VIP         : Factor w/ 3 levels \"\",\"False\",\"True\": 2 2 3 2 2 2 2 2 2 2 ...\n",
      " $ RoomService : num  0 109 43 0 303 0 42 0 0 0 ...\n",
      " $ FoodCourt   : num  0 9 3576 1283 70 ...\n",
      " $ ShoppingMall: num  0 25 0 371 151 0 3 0 17 0 ...\n",
      " $ Spa         : num  0 549 6715 3329 565 ...\n",
      " $ VRDeck      : num  0 44 49 193 2 ...\n",
      " $ Name        : Factor w/ 12630 levels \"\",\"Aard Backo\",..: 7821 6690 671 10690 12402 10285 1735 2184 844 4288 ...\n",
      " $ Transported : Factor w/ 2 levels \"False\",\"True\": 1 2 1 1 2 2 2 2 2 2 ...\n",
      " $ IsTrain     : logi  TRUE TRUE TRUE TRUE TRUE TRUE ...\n"
     ]
    }
   ],
   "source": [
    "full_space = full_space |> mutate_if(is.character, as.factor)\n",
    "str(full_space)\n",
    "\n",
    "full_space$Cabin = as.character(full_space$Cabin)\n",
    "full_space$PassengerId = as.character(full_space$PassengerId)\n",
    "full_space$Name = as.character(full_space$Name)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "26cbaaec",
   "metadata": {
    "papermill": {
     "duration": 0.013184,
     "end_time": "2024-07-21T03:02:31.149139",
     "exception": false,
     "start_time": "2024-07-21T03:02:31.135955",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Separating the data frames ------------------------------------------"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "ae77d27f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:02:31.177429Z",
     "iopub.status.busy": "2024-07-21T03:02:31.176117Z",
     "iopub.status.idle": "2024-07-21T03:02:31.203490Z",
     "shell.execute_reply": "2024-07-21T03:02:31.201561Z"
    },
    "papermill": {
     "duration": 0.04366,
     "end_time": "2024-07-21T03:02:31.205523",
     "exception": false,
     "start_time": "2024-07-21T03:02:31.161863",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t8693 obs. of  14 variables:\n",
      " $ PassengerId : chr  \"0001_01\" \"0002_01\" \"0003_01\" \"0003_02\" ...\n",
      " $ HomePlanet  : Factor w/ 4 levels \"\",\"Earth\",\"Europa\",..: 3 2 3 3 2 2 2 2 2 3 ...\n",
      " $ CryoSleep   : Factor w/ 3 levels \"\",\"False\",\"True\": 2 2 2 2 2 2 2 3 2 3 ...\n",
      " $ Cabin       : chr  \"B/0/P\" \"F/0/S\" \"A/0/S\" \"A/0/S\" ...\n",
      " $ Destination : Factor w/ 4 levels \"\",\"55 Cancri e\",..: 4 4 4 4 4 3 4 4 4 2 ...\n",
      " $ Age         : num  39 24 58 33 16 44 26 28 35 14 ...\n",
      " $ VIP         : Factor w/ 3 levels \"\",\"False\",\"True\": 2 2 3 2 2 2 2 2 2 2 ...\n",
      " $ RoomService : num  0 109 43 0 303 0 42 0 0 0 ...\n",
      " $ FoodCourt   : num  0 9 3576 1283 70 ...\n",
      " $ ShoppingMall: num  0 25 0 371 151 0 3 0 17 0 ...\n",
      " $ Spa         : num  0 549 6715 3329 565 ...\n",
      " $ VRDeck      : num  0 44 49 193 2 ...\n",
      " $ Name        : chr  \"Maham Ofracculy\" \"Juanna Vines\" \"Altark Susent\" \"Solam Susent\" ...\n",
      " $ Transported : Factor w/ 2 levels \"False\",\"True\": 1 2 1 1 2 2 2 2 2 2 ...\n"
     ]
    }
   ],
   "source": [
    "train_space = full_space[full_space$IsTrain == TRUE,]\n",
    "\n",
    "train_space$IsTrain = NULL\n",
    "\n",
    "str(train_space)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "60322ab7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:02:31.234237Z",
     "iopub.status.busy": "2024-07-21T03:02:31.232944Z",
     "iopub.status.idle": "2024-07-21T03:02:31.259752Z",
     "shell.execute_reply": "2024-07-21T03:02:31.257752Z"
    },
    "papermill": {
     "duration": 0.043336,
     "end_time": "2024-07-21T03:02:31.261802",
     "exception": false,
     "start_time": "2024-07-21T03:02:31.218466",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t4277 obs. of  14 variables:\n",
      " $ PassengerId : chr  \"0013_01\" \"0018_01\" \"0019_01\" \"0021_01\" ...\n",
      " $ HomePlanet  : Factor w/ 4 levels \"\",\"Earth\",\"Europa\",..: 2 2 3 3 2 2 3 3 3 2 ...\n",
      " $ CryoSleep   : Factor w/ 3 levels \"\",\"False\",\"True\": 3 2 3 2 2 2 3 3 3 2 ...\n",
      " $ Cabin       : chr  \"G/3/S\" \"F/4/S\" \"C/0/S\" \"C/1/S\" ...\n",
      " $ Destination : Factor w/ 4 levels \"\",\"55 Cancri e\",..: 4 4 2 4 4 4 2 4 2 2 ...\n",
      " $ Age         : num  27 19 31 38 20 31 21 20 23 24 ...\n",
      " $ VIP         : Factor w/ 3 levels \"\",\"False\",\"True\": 2 2 2 2 2 2 2 2 2 2 ...\n",
      " $ RoomService : num  0 0 0 0 10 0 0 0 0 0 ...\n",
      " $ FoodCourt   : num  0 9 0 6652 0 ...\n",
      " $ ShoppingMall: num  0 0 0 0 635 263 0 0 0 0 ...\n",
      " $ Spa         : num  0 2823 0 181 0 ...\n",
      " $ VRDeck      : num  0 0 0 585 0 60 0 0 0 0 ...\n",
      " $ Name        : chr  \"Nelly Carsoning\" \"Lerome Peckers\" \"Sabih Unhearfus\" \"Meratz Caltilter\" ...\n",
      " $ Transported : Factor w/ 2 levels \"False\",\"True\": NA NA NA NA NA NA NA NA NA NA ...\n"
     ]
    }
   ],
   "source": [
    "test_space = full_space[full_space$IsTrain == FALSE,]\n",
    "\n",
    "test_space$IsTrain = NULL\n",
    "\n",
    "str(test_space)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "f9378213",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:02:31.290711Z",
     "iopub.status.busy": "2024-07-21T03:02:31.289361Z",
     "iopub.status.idle": "2024-07-21T03:02:31.310587Z",
     "shell.execute_reply": "2024-07-21T03:02:31.308522Z"
    },
    "papermill": {
     "duration": 0.037945,
     "end_time": "2024-07-21T03:02:31.312661",
     "exception": false,
     "start_time": "2024-07-21T03:02:31.274716",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t4277 obs. of  14 variables:\n",
      " $ PassengerId : chr  \"0013_01\" \"0018_01\" \"0019_01\" \"0021_01\" ...\n",
      " $ HomePlanet  : Factor w/ 4 levels \"\",\"Earth\",\"Europa\",..: 2 2 3 3 2 2 3 3 3 2 ...\n",
      " $ CryoSleep   : Factor w/ 3 levels \"\",\"False\",\"True\": 3 2 3 2 2 2 3 3 3 2 ...\n",
      " $ Cabin       : chr  \"G/3/S\" \"F/4/S\" \"C/0/S\" \"C/1/S\" ...\n",
      " $ Destination : Factor w/ 4 levels \"\",\"55 Cancri e\",..: 4 4 2 4 4 4 2 4 2 2 ...\n",
      " $ Age         : num  27 19 31 38 20 31 21 20 23 24 ...\n",
      " $ VIP         : Factor w/ 3 levels \"\",\"False\",\"True\": 2 2 2 2 2 2 2 2 2 2 ...\n",
      " $ RoomService : num  0 0 0 0 10 0 0 0 0 0 ...\n",
      " $ FoodCourt   : num  0 9 0 6652 0 ...\n",
      " $ ShoppingMall: num  0 0 0 0 635 263 0 0 0 0 ...\n",
      " $ Spa         : num  0 2823 0 181 0 ...\n",
      " $ VRDeck      : num  0 0 0 585 0 60 0 0 0 0 ...\n",
      " $ Name        : chr  \"Nelly Carsoning\" \"Lerome Peckers\" \"Sabih Unhearfus\" \"Meratz Caltilter\" ...\n",
      " $ Transported : Factor w/ 2 levels \"False\",\"True\": NA NA NA NA NA NA NA NA NA NA ...\n"
     ]
    }
   ],
   "source": [
    "str(test_space)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "32880dde",
   "metadata": {
    "papermill": {
     "duration": 0.013209,
     "end_time": "2024-07-21T03:02:31.339007",
     "exception": false,
     "start_time": "2024-07-21T03:02:31.325798",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Bulding Model ---------------------------------------------------------------"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "8b71142a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:02:31.367949Z",
     "iopub.status.busy": "2024-07-21T03:02:31.366533Z",
     "iopub.status.idle": "2024-07-21T03:02:41.699774Z",
     "shell.execute_reply": "2024-07-21T03:02:41.697817Z"
    },
    "papermill": {
     "duration": 10.350154,
     "end_time": "2024-07-21T03:02:41.702222",
     "exception": false,
     "start_time": "2024-07-21T03:02:31.352068",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "formula_space = \"Transported ~ HomePlanet + CryoSleep + Cabin + Destination + Age + VIP + RoomService +FoodCourt + ShoppingMall + Spa + VRDeck\"\n",
    "formula_space = as.formula(formula_space)\n",
    "\n",
    "\n",
    "model_space = randomForest(formula = formula_space, data = train_space, ntree = 1000, mtry = 3, nodesize = 0.01 * nrow(train_space))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "cd172f25",
   "metadata": {
    "papermill": {
     "duration": 0.013514,
     "end_time": "2024-07-21T03:02:41.729832",
     "exception": false,
     "start_time": "2024-07-21T03:02:41.716318",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Predicting "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "96794999",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:02:41.759071Z",
     "iopub.status.busy": "2024-07-21T03:02:41.757682Z",
     "iopub.status.idle": "2024-07-21T03:02:42.129054Z",
     "shell.execute_reply": "2024-07-21T03:02:42.127489Z"
    },
    "papermill": {
     "duration": 0.388534,
     "end_time": "2024-07-21T03:02:42.131332",
     "exception": false,
     "start_time": "2024-07-21T03:02:41.742798",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "space_output\n",
       "False  True \n",
       " 1930  2347 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "features_output = \"HomePlanet + CryoSleep + Cabin + Destination + Age + VIP + RoomService +FoodCourt + ShoppingMall + Spa + VRDeck\"\n",
    "\n",
    " space_output = predict(model_space, newdata = test_space)\n",
    "     table(space_output)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "1301c474",
   "metadata": {
    "papermill": {
     "duration": 0.01346,
     "end_time": "2024-07-21T03:02:42.157944",
     "exception": false,
     "start_time": "2024-07-21T03:02:42.144484",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Output"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "1eeea243",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:02:42.187181Z",
     "iopub.status.busy": "2024-07-21T03:02:42.185792Z",
     "iopub.status.idle": "2024-07-21T03:02:42.197261Z",
     "shell.execute_reply": "2024-07-21T03:02:42.195858Z"
    },
    "papermill": {
     "duration": 0.027845,
     "end_time": "2024-07-21T03:02:42.199242",
     "exception": false,
     "start_time": "2024-07-21T03:02:42.171397",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "space_output = as.data.frame(space_output)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "id": "0e91a1ce",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:02:42.228778Z",
     "iopub.status.busy": "2024-07-21T03:02:42.227305Z",
     "iopub.status.idle": "2024-07-21T03:02:42.238697Z",
     "shell.execute_reply": "2024-07-21T03:02:42.237359Z"
    },
    "papermill": {
     "duration": 0.028448,
     "end_time": "2024-07-21T03:02:42.240898",
     "exception": false,
     "start_time": "2024-07-21T03:02:42.212450",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "space_output$PassengerId = test_space$PassengerId"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 22,
   "id": "f44afb4d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:02:42.269589Z",
     "iopub.status.busy": "2024-07-21T03:02:42.268318Z",
     "iopub.status.idle": "2024-07-21T03:02:42.326894Z",
     "shell.execute_reply": "2024-07-21T03:02:42.325245Z"
    },
    "papermill": {
     "duration": 0.075347,
     "end_time": "2024-07-21T03:02:42.329148",
     "exception": false,
     "start_time": "2024-07-21T03:02:42.253801",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 4277 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>space_output</th><th scope=col>PassengerId</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>8694</th><td>True </td><td>0013_01</td></tr>\n",
       "\t<tr><th scope=row>8695</th><td>False</td><td>0018_01</td></tr>\n",
       "\t<tr><th scope=row>8696</th><td>True </td><td>0019_01</td></tr>\n",
       "\t<tr><th scope=row>8697</th><td>True </td><td>0021_01</td></tr>\n",
       "\t<tr><th scope=row>8698</th><td>True </td><td>0023_01</td></tr>\n",
       "\t<tr><th scope=row>8699</th><td>True </td><td>0027_01</td></tr>\n",
       "\t<tr><th scope=row>8700</th><td>True </td><td>0029_01</td></tr>\n",
       "\t<tr><th scope=row>8701</th><td>True </td><td>0032_01</td></tr>\n",
       "\t<tr><th scope=row>8702</th><td>True </td><td>0032_02</td></tr>\n",
       "\t<tr><th scope=row>8703</th><td>True </td><td>0033_01</td></tr>\n",
       "\t<tr><th scope=row>8704</th><td>False</td><td>0037_01</td></tr>\n",
       "\t<tr><th scope=row>8705</th><td>False</td><td>0040_01</td></tr>\n",
       "\t<tr><th scope=row>8706</th><td>True </td><td>0040_02</td></tr>\n",
       "\t<tr><th scope=row>8707</th><td>True </td><td>0042_01</td></tr>\n",
       "\t<tr><th scope=row>8708</th><td>False</td><td>0046_01</td></tr>\n",
       "\t<tr><th scope=row>8709</th><td>False</td><td>0046_02</td></tr>\n",
       "\t<tr><th scope=row>8710</th><td>False</td><td>0046_03</td></tr>\n",
       "\t<tr><th scope=row>8711</th><td>True </td><td>0047_01</td></tr>\n",
       "\t<tr><th scope=row>8712</th><td>True </td><td>0047_02</td></tr>\n",
       "\t<tr><th scope=row>8713</th><td>False</td><td>0047_03</td></tr>\n",
       "\t<tr><th scope=row>8714</th><td>True </td><td>0048_01</td></tr>\n",
       "\t<tr><th scope=row>8715</th><td>False</td><td>0049_01</td></tr>\n",
       "\t<tr><th scope=row>8716</th><td>True </td><td>0054_01</td></tr>\n",
       "\t<tr><th scope=row>8717</th><td>True </td><td>0054_02</td></tr>\n",
       "\t<tr><th scope=row>8718</th><td>False</td><td>0054_03</td></tr>\n",
       "\t<tr><th scope=row>8719</th><td>False</td><td>0055_01</td></tr>\n",
       "\t<tr><th scope=row>8720</th><td>True </td><td>0057_01</td></tr>\n",
       "\t<tr><th scope=row>8721</th><td>True </td><td>0059_01</td></tr>\n",
       "\t<tr><th scope=row>8722</th><td>True </td><td>0060_01</td></tr>\n",
       "\t<tr><th scope=row>8723</th><td>True </td><td>0063_01</td></tr>\n",
       "\t<tr><th scope=row>⋮</th><td>⋮</td><td>⋮</td></tr>\n",
       "\t<tr><th scope=row>12941</th><td>False</td><td>9216_01</td></tr>\n",
       "\t<tr><th scope=row>12942</th><td>True </td><td>9223_01</td></tr>\n",
       "\t<tr><th scope=row>12943</th><td>True </td><td>9223_02</td></tr>\n",
       "\t<tr><th scope=row>12944</th><td>False</td><td>9228_01</td></tr>\n",
       "\t<tr><th scope=row>12945</th><td>False</td><td>9229_01</td></tr>\n",
       "\t<tr><th scope=row>12946</th><td>False</td><td>9232_01</td></tr>\n",
       "\t<tr><th scope=row>12947</th><td>True </td><td>9236_01</td></tr>\n",
       "\t<tr><th scope=row>12948</th><td>True </td><td>9238_01</td></tr>\n",
       "\t<tr><th scope=row>12949</th><td>True </td><td>9238_02</td></tr>\n",
       "\t<tr><th scope=row>12950</th><td>True </td><td>9238_03</td></tr>\n",
       "\t<tr><th scope=row>12951</th><td>False</td><td>9238_04</td></tr>\n",
       "\t<tr><th scope=row>12952</th><td>True </td><td>9238_05</td></tr>\n",
       "\t<tr><th scope=row>12953</th><td>True </td><td>9238_06</td></tr>\n",
       "\t<tr><th scope=row>12954</th><td>False</td><td>9238_07</td></tr>\n",
       "\t<tr><th scope=row>12955</th><td>False</td><td>9240_01</td></tr>\n",
       "\t<tr><th scope=row>12956</th><td>True </td><td>9243_01</td></tr>\n",
       "\t<tr><th scope=row>12957</th><td>False</td><td>9245_01</td></tr>\n",
       "\t<tr><th scope=row>12958</th><td>False</td><td>9249_01</td></tr>\n",
       "\t<tr><th scope=row>12959</th><td>True </td><td>9255_01</td></tr>\n",
       "\t<tr><th scope=row>12960</th><td>True </td><td>9258_01</td></tr>\n",
       "\t<tr><th scope=row>12961</th><td>True </td><td>9260_01</td></tr>\n",
       "\t<tr><th scope=row>12962</th><td>True </td><td>9262_01</td></tr>\n",
       "\t<tr><th scope=row>12963</th><td>True </td><td>9263_01</td></tr>\n",
       "\t<tr><th scope=row>12964</th><td>True </td><td>9265_01</td></tr>\n",
       "\t<tr><th scope=row>12965</th><td>True </td><td>9266_01</td></tr>\n",
       "\t<tr><th scope=row>12966</th><td>True </td><td>9266_02</td></tr>\n",
       "\t<tr><th scope=row>12967</th><td>False</td><td>9269_01</td></tr>\n",
       "\t<tr><th scope=row>12968</th><td>True </td><td>9271_01</td></tr>\n",
       "\t<tr><th scope=row>12969</th><td>True </td><td>9273_01</td></tr>\n",
       "\t<tr><th scope=row>12970</th><td>True </td><td>9277_01</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 4277 × 2\n",
       "\\begin{tabular}{r|ll}\n",
       "  & space\\_output & PassengerId\\\\\n",
       "  & <fct> & <chr>\\\\\n",
       "\\hline\n",
       "\t8694 & True  & 0013\\_01\\\\\n",
       "\t8695 & False & 0018\\_01\\\\\n",
       "\t8696 & True  & 0019\\_01\\\\\n",
       "\t8697 & True  & 0021\\_01\\\\\n",
       "\t8698 & True  & 0023\\_01\\\\\n",
       "\t8699 & True  & 0027\\_01\\\\\n",
       "\t8700 & True  & 0029\\_01\\\\\n",
       "\t8701 & True  & 0032\\_01\\\\\n",
       "\t8702 & True  & 0032\\_02\\\\\n",
       "\t8703 & True  & 0033\\_01\\\\\n",
       "\t8704 & False & 0037\\_01\\\\\n",
       "\t8705 & False & 0040\\_01\\\\\n",
       "\t8706 & True  & 0040\\_02\\\\\n",
       "\t8707 & True  & 0042\\_01\\\\\n",
       "\t8708 & False & 0046\\_01\\\\\n",
       "\t8709 & False & 0046\\_02\\\\\n",
       "\t8710 & False & 0046\\_03\\\\\n",
       "\t8711 & True  & 0047\\_01\\\\\n",
       "\t8712 & True  & 0047\\_02\\\\\n",
       "\t8713 & False & 0047\\_03\\\\\n",
       "\t8714 & True  & 0048\\_01\\\\\n",
       "\t8715 & False & 0049\\_01\\\\\n",
       "\t8716 & True  & 0054\\_01\\\\\n",
       "\t8717 & True  & 0054\\_02\\\\\n",
       "\t8718 & False & 0054\\_03\\\\\n",
       "\t8719 & False & 0055\\_01\\\\\n",
       "\t8720 & True  & 0057\\_01\\\\\n",
       "\t8721 & True  & 0059\\_01\\\\\n",
       "\t8722 & True  & 0060\\_01\\\\\n",
       "\t8723 & True  & 0063\\_01\\\\\n",
       "\t⋮ & ⋮ & ⋮\\\\\n",
       "\t12941 & False & 9216\\_01\\\\\n",
       "\t12942 & True  & 9223\\_01\\\\\n",
       "\t12943 & True  & 9223\\_02\\\\\n",
       "\t12944 & False & 9228\\_01\\\\\n",
       "\t12945 & False & 9229\\_01\\\\\n",
       "\t12946 & False & 9232\\_01\\\\\n",
       "\t12947 & True  & 9236\\_01\\\\\n",
       "\t12948 & True  & 9238\\_01\\\\\n",
       "\t12949 & True  & 9238\\_02\\\\\n",
       "\t12950 & True  & 9238\\_03\\\\\n",
       "\t12951 & False & 9238\\_04\\\\\n",
       "\t12952 & True  & 9238\\_05\\\\\n",
       "\t12953 & True  & 9238\\_06\\\\\n",
       "\t12954 & False & 9238\\_07\\\\\n",
       "\t12955 & False & 9240\\_01\\\\\n",
       "\t12956 & True  & 9243\\_01\\\\\n",
       "\t12957 & False & 9245\\_01\\\\\n",
       "\t12958 & False & 9249\\_01\\\\\n",
       "\t12959 & True  & 9255\\_01\\\\\n",
       "\t12960 & True  & 9258\\_01\\\\\n",
       "\t12961 & True  & 9260\\_01\\\\\n",
       "\t12962 & True  & 9262\\_01\\\\\n",
       "\t12963 & True  & 9263\\_01\\\\\n",
       "\t12964 & True  & 9265\\_01\\\\\n",
       "\t12965 & True  & 9266\\_01\\\\\n",
       "\t12966 & True  & 9266\\_02\\\\\n",
       "\t12967 & False & 9269\\_01\\\\\n",
       "\t12968 & True  & 9271\\_01\\\\\n",
       "\t12969 & True  & 9273\\_01\\\\\n",
       "\t12970 & True  & 9277\\_01\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 4277 × 2\n",
       "\n",
       "| <!--/--> | space_output &lt;fct&gt; | PassengerId &lt;chr&gt; |\n",
       "|---|---|---|\n",
       "| 8694 | True  | 0013_01 |\n",
       "| 8695 | False | 0018_01 |\n",
       "| 8696 | True  | 0019_01 |\n",
       "| 8697 | True  | 0021_01 |\n",
       "| 8698 | True  | 0023_01 |\n",
       "| 8699 | True  | 0027_01 |\n",
       "| 8700 | True  | 0029_01 |\n",
       "| 8701 | True  | 0032_01 |\n",
       "| 8702 | True  | 0032_02 |\n",
       "| 8703 | True  | 0033_01 |\n",
       "| 8704 | False | 0037_01 |\n",
       "| 8705 | False | 0040_01 |\n",
       "| 8706 | True  | 0040_02 |\n",
       "| 8707 | True  | 0042_01 |\n",
       "| 8708 | False | 0046_01 |\n",
       "| 8709 | False | 0046_02 |\n",
       "| 8710 | False | 0046_03 |\n",
       "| 8711 | True  | 0047_01 |\n",
       "| 8712 | True  | 0047_02 |\n",
       "| 8713 | False | 0047_03 |\n",
       "| 8714 | True  | 0048_01 |\n",
       "| 8715 | False | 0049_01 |\n",
       "| 8716 | True  | 0054_01 |\n",
       "| 8717 | True  | 0054_02 |\n",
       "| 8718 | False | 0054_03 |\n",
       "| 8719 | False | 0055_01 |\n",
       "| 8720 | True  | 0057_01 |\n",
       "| 8721 | True  | 0059_01 |\n",
       "| 8722 | True  | 0060_01 |\n",
       "| 8723 | True  | 0063_01 |\n",
       "| ⋮ | ⋮ | ⋮ |\n",
       "| 12941 | False | 9216_01 |\n",
       "| 12942 | True  | 9223_01 |\n",
       "| 12943 | True  | 9223_02 |\n",
       "| 12944 | False | 9228_01 |\n",
       "| 12945 | False | 9229_01 |\n",
       "| 12946 | False | 9232_01 |\n",
       "| 12947 | True  | 9236_01 |\n",
       "| 12948 | True  | 9238_01 |\n",
       "| 12949 | True  | 9238_02 |\n",
       "| 12950 | True  | 9238_03 |\n",
       "| 12951 | False | 9238_04 |\n",
       "| 12952 | True  | 9238_05 |\n",
       "| 12953 | True  | 9238_06 |\n",
       "| 12954 | False | 9238_07 |\n",
       "| 12955 | False | 9240_01 |\n",
       "| 12956 | True  | 9243_01 |\n",
       "| 12957 | False | 9245_01 |\n",
       "| 12958 | False | 9249_01 |\n",
       "| 12959 | True  | 9255_01 |\n",
       "| 12960 | True  | 9258_01 |\n",
       "| 12961 | True  | 9260_01 |\n",
       "| 12962 | True  | 9262_01 |\n",
       "| 12963 | True  | 9263_01 |\n",
       "| 12964 | True  | 9265_01 |\n",
       "| 12965 | True  | 9266_01 |\n",
       "| 12966 | True  | 9266_02 |\n",
       "| 12967 | False | 9269_01 |\n",
       "| 12968 | True  | 9271_01 |\n",
       "| 12969 | True  | 9273_01 |\n",
       "| 12970 | True  | 9277_01 |\n",
       "\n"
      ],
      "text/plain": [
       "      space_output PassengerId\n",
       "8694  True         0013_01    \n",
       "8695  False        0018_01    \n",
       "8696  True         0019_01    \n",
       "8697  True         0021_01    \n",
       "8698  True         0023_01    \n",
       "8699  True         0027_01    \n",
       "8700  True         0029_01    \n",
       "8701  True         0032_01    \n",
       "8702  True         0032_02    \n",
       "8703  True         0033_01    \n",
       "8704  False        0037_01    \n",
       "8705  False        0040_01    \n",
       "8706  True         0040_02    \n",
       "8707  True         0042_01    \n",
       "8708  False        0046_01    \n",
       "8709  False        0046_02    \n",
       "8710  False        0046_03    \n",
       "8711  True         0047_01    \n",
       "8712  True         0047_02    \n",
       "8713  False        0047_03    \n",
       "8714  True         0048_01    \n",
       "8715  False        0049_01    \n",
       "8716  True         0054_01    \n",
       "8717  True         0054_02    \n",
       "8718  False        0054_03    \n",
       "8719  False        0055_01    \n",
       "8720  True         0057_01    \n",
       "8721  True         0059_01    \n",
       "8722  True         0060_01    \n",
       "8723  True         0063_01    \n",
       "⋮     ⋮            ⋮          \n",
       "12941 False        9216_01    \n",
       "12942 True         9223_01    \n",
       "12943 True         9223_02    \n",
       "12944 False        9228_01    \n",
       "12945 False        9229_01    \n",
       "12946 False        9232_01    \n",
       "12947 True         9236_01    \n",
       "12948 True         9238_01    \n",
       "12949 True         9238_02    \n",
       "12950 True         9238_03    \n",
       "12951 False        9238_04    \n",
       "12952 True         9238_05    \n",
       "12953 True         9238_06    \n",
       "12954 False        9238_07    \n",
       "12955 False        9240_01    \n",
       "12956 True         9243_01    \n",
       "12957 False        9245_01    \n",
       "12958 False        9249_01    \n",
       "12959 True         9255_01    \n",
       "12960 True         9258_01    \n",
       "12961 True         9260_01    \n",
       "12962 True         9262_01    \n",
       "12963 True         9263_01    \n",
       "12964 True         9265_01    \n",
       "12965 True         9266_01    \n",
       "12966 True         9266_02    \n",
       "12967 False        9269_01    \n",
       "12968 True         9271_01    \n",
       "12969 True         9273_01    \n",
       "12970 True         9277_01    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "View(space_output)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "id": "5d4b3fdc",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:02:42.361048Z",
     "iopub.status.busy": "2024-07-21T03:02:42.359635Z",
     "iopub.status.idle": "2024-07-21T03:02:42.418613Z",
     "shell.execute_reply": "2024-07-21T03:02:42.417110Z"
    },
    "papermill": {
     "duration": 0.077176,
     "end_time": "2024-07-21T03:02:42.420878",
     "exception": false,
     "start_time": "2024-07-21T03:02:42.343702",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 4277 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>PassengerId</th><th scope=col>Transported</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;fct&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>8694</th><td>0013_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8695</th><td>0018_01</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>8696</th><td>0019_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8697</th><td>0021_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8698</th><td>0023_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8699</th><td>0027_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8700</th><td>0029_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8701</th><td>0032_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8702</th><td>0032_02</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8703</th><td>0033_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8704</th><td>0037_01</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>8705</th><td>0040_01</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>8706</th><td>0040_02</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8707</th><td>0042_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8708</th><td>0046_01</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>8709</th><td>0046_02</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>8710</th><td>0046_03</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>8711</th><td>0047_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8712</th><td>0047_02</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8713</th><td>0047_03</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>8714</th><td>0048_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8715</th><td>0049_01</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>8716</th><td>0054_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8717</th><td>0054_02</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8718</th><td>0054_03</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>8719</th><td>0055_01</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>8720</th><td>0057_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8721</th><td>0059_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8722</th><td>0060_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>8723</th><td>0063_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>⋮</th><td>⋮</td><td>⋮</td></tr>\n",
       "\t<tr><th scope=row>12941</th><td>9216_01</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>12942</th><td>9223_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12943</th><td>9223_02</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12944</th><td>9228_01</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>12945</th><td>9229_01</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>12946</th><td>9232_01</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>12947</th><td>9236_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12948</th><td>9238_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12949</th><td>9238_02</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12950</th><td>9238_03</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12951</th><td>9238_04</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>12952</th><td>9238_05</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12953</th><td>9238_06</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12954</th><td>9238_07</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>12955</th><td>9240_01</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>12956</th><td>9243_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12957</th><td>9245_01</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>12958</th><td>9249_01</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>12959</th><td>9255_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12960</th><td>9258_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12961</th><td>9260_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12962</th><td>9262_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12963</th><td>9263_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12964</th><td>9265_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12965</th><td>9266_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12966</th><td>9266_02</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12967</th><td>9269_01</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>12968</th><td>9271_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12969</th><td>9273_01</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>12970</th><td>9277_01</td><td>True </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 4277 × 2\n",
       "\\begin{tabular}{r|ll}\n",
       "  & PassengerId & Transported\\\\\n",
       "  & <chr> & <fct>\\\\\n",
       "\\hline\n",
       "\t8694 & 0013\\_01 & True \\\\\n",
       "\t8695 & 0018\\_01 & False\\\\\n",
       "\t8696 & 0019\\_01 & True \\\\\n",
       "\t8697 & 0021\\_01 & True \\\\\n",
       "\t8698 & 0023\\_01 & True \\\\\n",
       "\t8699 & 0027\\_01 & True \\\\\n",
       "\t8700 & 0029\\_01 & True \\\\\n",
       "\t8701 & 0032\\_01 & True \\\\\n",
       "\t8702 & 0032\\_02 & True \\\\\n",
       "\t8703 & 0033\\_01 & True \\\\\n",
       "\t8704 & 0037\\_01 & False\\\\\n",
       "\t8705 & 0040\\_01 & False\\\\\n",
       "\t8706 & 0040\\_02 & True \\\\\n",
       "\t8707 & 0042\\_01 & True \\\\\n",
       "\t8708 & 0046\\_01 & False\\\\\n",
       "\t8709 & 0046\\_02 & False\\\\\n",
       "\t8710 & 0046\\_03 & False\\\\\n",
       "\t8711 & 0047\\_01 & True \\\\\n",
       "\t8712 & 0047\\_02 & True \\\\\n",
       "\t8713 & 0047\\_03 & False\\\\\n",
       "\t8714 & 0048\\_01 & True \\\\\n",
       "\t8715 & 0049\\_01 & False\\\\\n",
       "\t8716 & 0054\\_01 & True \\\\\n",
       "\t8717 & 0054\\_02 & True \\\\\n",
       "\t8718 & 0054\\_03 & False\\\\\n",
       "\t8719 & 0055\\_01 & False\\\\\n",
       "\t8720 & 0057\\_01 & True \\\\\n",
       "\t8721 & 0059\\_01 & True \\\\\n",
       "\t8722 & 0060\\_01 & True \\\\\n",
       "\t8723 & 0063\\_01 & True \\\\\n",
       "\t⋮ & ⋮ & ⋮\\\\\n",
       "\t12941 & 9216\\_01 & False\\\\\n",
       "\t12942 & 9223\\_01 & True \\\\\n",
       "\t12943 & 9223\\_02 & True \\\\\n",
       "\t12944 & 9228\\_01 & False\\\\\n",
       "\t12945 & 9229\\_01 & False\\\\\n",
       "\t12946 & 9232\\_01 & False\\\\\n",
       "\t12947 & 9236\\_01 & True \\\\\n",
       "\t12948 & 9238\\_01 & True \\\\\n",
       "\t12949 & 9238\\_02 & True \\\\\n",
       "\t12950 & 9238\\_03 & True \\\\\n",
       "\t12951 & 9238\\_04 & False\\\\\n",
       "\t12952 & 9238\\_05 & True \\\\\n",
       "\t12953 & 9238\\_06 & True \\\\\n",
       "\t12954 & 9238\\_07 & False\\\\\n",
       "\t12955 & 9240\\_01 & False\\\\\n",
       "\t12956 & 9243\\_01 & True \\\\\n",
       "\t12957 & 9245\\_01 & False\\\\\n",
       "\t12958 & 9249\\_01 & False\\\\\n",
       "\t12959 & 9255\\_01 & True \\\\\n",
       "\t12960 & 9258\\_01 & True \\\\\n",
       "\t12961 & 9260\\_01 & True \\\\\n",
       "\t12962 & 9262\\_01 & True \\\\\n",
       "\t12963 & 9263\\_01 & True \\\\\n",
       "\t12964 & 9265\\_01 & True \\\\\n",
       "\t12965 & 9266\\_01 & True \\\\\n",
       "\t12966 & 9266\\_02 & True \\\\\n",
       "\t12967 & 9269\\_01 & False\\\\\n",
       "\t12968 & 9271\\_01 & True \\\\\n",
       "\t12969 & 9273\\_01 & True \\\\\n",
       "\t12970 & 9277\\_01 & True \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 4277 × 2\n",
       "\n",
       "| <!--/--> | PassengerId &lt;chr&gt; | Transported &lt;fct&gt; |\n",
       "|---|---|---|\n",
       "| 8694 | 0013_01 | True  |\n",
       "| 8695 | 0018_01 | False |\n",
       "| 8696 | 0019_01 | True  |\n",
       "| 8697 | 0021_01 | True  |\n",
       "| 8698 | 0023_01 | True  |\n",
       "| 8699 | 0027_01 | True  |\n",
       "| 8700 | 0029_01 | True  |\n",
       "| 8701 | 0032_01 | True  |\n",
       "| 8702 | 0032_02 | True  |\n",
       "| 8703 | 0033_01 | True  |\n",
       "| 8704 | 0037_01 | False |\n",
       "| 8705 | 0040_01 | False |\n",
       "| 8706 | 0040_02 | True  |\n",
       "| 8707 | 0042_01 | True  |\n",
       "| 8708 | 0046_01 | False |\n",
       "| 8709 | 0046_02 | False |\n",
       "| 8710 | 0046_03 | False |\n",
       "| 8711 | 0047_01 | True  |\n",
       "| 8712 | 0047_02 | True  |\n",
       "| 8713 | 0047_03 | False |\n",
       "| 8714 | 0048_01 | True  |\n",
       "| 8715 | 0049_01 | False |\n",
       "| 8716 | 0054_01 | True  |\n",
       "| 8717 | 0054_02 | True  |\n",
       "| 8718 | 0054_03 | False |\n",
       "| 8719 | 0055_01 | False |\n",
       "| 8720 | 0057_01 | True  |\n",
       "| 8721 | 0059_01 | True  |\n",
       "| 8722 | 0060_01 | True  |\n",
       "| 8723 | 0063_01 | True  |\n",
       "| ⋮ | ⋮ | ⋮ |\n",
       "| 12941 | 9216_01 | False |\n",
       "| 12942 | 9223_01 | True  |\n",
       "| 12943 | 9223_02 | True  |\n",
       "| 12944 | 9228_01 | False |\n",
       "| 12945 | 9229_01 | False |\n",
       "| 12946 | 9232_01 | False |\n",
       "| 12947 | 9236_01 | True  |\n",
       "| 12948 | 9238_01 | True  |\n",
       "| 12949 | 9238_02 | True  |\n",
       "| 12950 | 9238_03 | True  |\n",
       "| 12951 | 9238_04 | False |\n",
       "| 12952 | 9238_05 | True  |\n",
       "| 12953 | 9238_06 | True  |\n",
       "| 12954 | 9238_07 | False |\n",
       "| 12955 | 9240_01 | False |\n",
       "| 12956 | 9243_01 | True  |\n",
       "| 12957 | 9245_01 | False |\n",
       "| 12958 | 9249_01 | False |\n",
       "| 12959 | 9255_01 | True  |\n",
       "| 12960 | 9258_01 | True  |\n",
       "| 12961 | 9260_01 | True  |\n",
       "| 12962 | 9262_01 | True  |\n",
       "| 12963 | 9263_01 | True  |\n",
       "| 12964 | 9265_01 | True  |\n",
       "| 12965 | 9266_01 | True  |\n",
       "| 12966 | 9266_02 | True  |\n",
       "| 12967 | 9269_01 | False |\n",
       "| 12968 | 9271_01 | True  |\n",
       "| 12969 | 9273_01 | True  |\n",
       "| 12970 | 9277_01 | True  |\n",
       "\n"
      ],
      "text/plain": [
       "      PassengerId Transported\n",
       "8694  0013_01     True       \n",
       "8695  0018_01     False      \n",
       "8696  0019_01     True       \n",
       "8697  0021_01     True       \n",
       "8698  0023_01     True       \n",
       "8699  0027_01     True       \n",
       "8700  0029_01     True       \n",
       "8701  0032_01     True       \n",
       "8702  0032_02     True       \n",
       "8703  0033_01     True       \n",
       "8704  0037_01     False      \n",
       "8705  0040_01     False      \n",
       "8706  0040_02     True       \n",
       "8707  0042_01     True       \n",
       "8708  0046_01     False      \n",
       "8709  0046_02     False      \n",
       "8710  0046_03     False      \n",
       "8711  0047_01     True       \n",
       "8712  0047_02     True       \n",
       "8713  0047_03     False      \n",
       "8714  0048_01     True       \n",
       "8715  0049_01     False      \n",
       "8716  0054_01     True       \n",
       "8717  0054_02     True       \n",
       "8718  0054_03     False      \n",
       "8719  0055_01     False      \n",
       "8720  0057_01     True       \n",
       "8721  0059_01     True       \n",
       "8722  0060_01     True       \n",
       "8723  0063_01     True       \n",
       "⋮     ⋮           ⋮          \n",
       "12941 9216_01     False      \n",
       "12942 9223_01     True       \n",
       "12943 9223_02     True       \n",
       "12944 9228_01     False      \n",
       "12945 9229_01     False      \n",
       "12946 9232_01     False      \n",
       "12947 9236_01     True       \n",
       "12948 9238_01     True       \n",
       "12949 9238_02     True       \n",
       "12950 9238_03     True       \n",
       "12951 9238_04     False      \n",
       "12952 9238_05     True       \n",
       "12953 9238_06     True       \n",
       "12954 9238_07     False      \n",
       "12955 9240_01     False      \n",
       "12956 9243_01     True       \n",
       "12957 9245_01     False      \n",
       "12958 9249_01     False      \n",
       "12959 9255_01     True       \n",
       "12960 9258_01     True       \n",
       "12961 9260_01     True       \n",
       "12962 9262_01     True       \n",
       "12963 9263_01     True       \n",
       "12964 9265_01     True       \n",
       "12965 9266_01     True       \n",
       "12966 9266_02     True       \n",
       "12967 9269_01     False      \n",
       "12968 9271_01     True       \n",
       "12969 9273_01     True       \n",
       "12970 9277_01     True       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "space_output$Transported = space_output$space_output\n",
    "\n",
    "space_output$space_output = NULL\n",
    "\n",
    "View(space_output)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "5e9deabf",
   "metadata": {
    "papermill": {
     "duration": 0.01407,
     "end_time": "2024-07-21T03:02:42.449522",
     "exception": false,
     "start_time": "2024-07-21T03:02:42.435452",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# export: write.csv"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 24,
   "id": "7a717e86",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-07-21T03:02:42.481037Z",
     "iopub.status.busy": "2024-07-21T03:02:42.479501Z",
     "iopub.status.idle": "2024-07-21T03:02:42.495454Z",
     "shell.execute_reply": "2024-07-21T03:02:42.493945Z"
    },
    "papermill": {
     "duration": 0.033839,
     "end_time": "2024-07-21T03:02:42.497539",
     "exception": false,
     "start_time": "2024-07-21T03:02:42.463700",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "    write.csv(space_output, file = \"imputet_space_submission.csv\", row.names = F)"
   ]
  }
 ],
 "metadata": {
  "kaggle": {
   "accelerator": "gpu",
   "dataSources": [
    {
     "databundleVersionId": 3220602,
     "sourceId": 34377,
     "sourceType": "competition"
    }
   ],
   "dockerImageVersionId": 30749,
   "isGpuEnabled": true,
   "isInternetEnabled": true,
   "language": "r",
   "sourceType": "notebook"
  },
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.4.0"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 159.931958,
   "end_time": "2024-07-21T03:02:42.730954",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2024-07-21T03:00:02.798996",
   "version": "2.6.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
